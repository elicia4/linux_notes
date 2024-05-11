# Exotica

[***Table of Contents***](./00-contents.md)

### Group Commands and Subshells

Commands can be grouped together either with the `group` command or with a
subshell. `group`:

```bash
{ command1; command2; [command3; ...] }
```

Subshell:

```bash
(command1; command2; [command3;...])
```

The two forms differ in that a group command surrounds its commands with braces
and a subshell uses parentheses. It is important to note that, because of the
way bash implements group commands, the braces must be separated from the
commands by a space and the last command must be terminated with either a
semicolon or a newline prior to the closing brace.

Group commands are used to manage redirection:

```bash
ls -l > output.txt
echo "Listing of foo.txt" >> output.txt
cat foo.txt >> output.txt
```

These three commands can be turned into one using the group command:

```bash
{ ls -l; echo "Listing of foo.txt"; cat foo.txt; } > output.txt
# OR
(ls -l; echo "Listing of foo.txt"; cat foo.txt) > output.txt
```

You can use pipes as well:

```bash
(ls -l; echo "Listing of foo.txt"; cat foo.txt) | lpr
```

#### Process Subsitution

There is an important difference between group commands and subshells. Whereas
a group command executes all of its commands in the current shell, a subshell
executes its commands in a child copy of the current shell. This means the
environment is copied and given to a new instance of the shell. When the
subshell exits, the copy of the environment is lost, so any changes made to the
subshell’s environment (including variable assignment) are lost as well.
Therefore, in most cases, unless a script requires a subshell, group commands
are preferable to subshells. Group commands are both faster and require less
memory.

A `read` command in a pipeline does not work as we might intuitively expect. If
we construct a pipeline like this:

```bash
echo "foo" | read
echo $REPLY
```

The content of `REPLY` is always empty because `read` is executed in a
subshell, and its copy of `REPLY` is destroyed when the subshell terminates.

Commands in pipelines are always executed in subshells, so any variable
assignmets will be lost. The shell provides an exotic form of expansion called
*process substitution* that can be used to work around this problem.

It can be done in two ways:

For processes that produce standard output: `<(list)`.
For processes that intake standard input: `>(list)`.

To solve the `read` problem, you can employ process substitution like this:

```bash
read < <(echo "foo")
echo $REPLY
```

Process substitution is often used with loops containing `read`. Here is an
example of a `read` loop that processes the contents of a directory listing
created by a subshell:

```bash
#!/bin/bash 

# pro-sub: demo of process substitution 

while read attr links owner group size date time filename; do 
cat <<- EOF 
        Filename:   $filename 
        Size:       $size 
        Owner:      $owner 
        Group:      $group 
        Modified:   $date $time 
        Links:      $links 
        Attributes: $attr 
    EOF 
done < <(ls -l | tail -n +2)
```

### Traps

Programs can respond to signals. `bash` provides a mechanism for this purpose
known as a *trap*. Traps are implemented with `trap`:

```bash
trap argument signal [signal...]
```

where `argument` is a string that will be read and treated as a command and
`signal` is the specification of a signal that will trigger the execution of
the interpreted command.

E.g.:

```bash
#!/bin/bash 

# trap-demo: simple signal handling demo 

trap "echo 'I am ignoring you.'" SIGINT SIGTERM 

for i in {1..5}; do 
    echo "Iteration $i of 5" 
    sleep 5 
done
```
```bash
Iteration 1 of 5 
Iteration 2 of 5 
^CI am ignoring you. 
Iteration 3 of 5 
^CI am ignoring you. 
Iteration 4 of 5
Iteration 5 of 5
```

It is common practice to specify a shell function as the command:

```bash
#!/bin/bash 

# trap-demo2: simple signal handling demo 

exit_on_signal_SIGINT () { 
    echo "Script interrupted." 2>&1 
    exit 0 
} 

exit_on_signal_SIGTERM () { 
    echo "Script terminated." 2>&1 
    exit 0 
} 

trap exit_on_signal_SIGINT SIGINT 
trap exit_on_signal_SIGTERM SIGTERM 

for i in {1..5}; do 
    echo "Iteration $i of 5" 
    sleep 5 
done
```

#### Temporary Files

During execution, many programs create temporary files. One of the uses of
signal handlers is to remove those files. Temporary files are usually kept in
the shared `/tmp` folder, making them unsafe. You should always set proper
permissions for these files and *make their names unpredictable*. The last
action is required to avoid the *temp race attack* exploit. One way to do it:

```bash
tempfile=/tmp/$(basename $0).$$.$RANDOM
```

This will create a filename consisting of the program's name, its process ID
(PID), and a random integer. `$RANDOM` shell variable returns only a value in
the range of *1-32767*, which is not a large range in computer terms, so a
single instance of the variable is unsafe.

It's better to use the `mktemp` program to name the file. The `mktemp` program
accepts a template as an argument. The template should include a series of `X`
characters, which are replaced by a corresponding number of random letters and
numbers:

```bash
tempfile=$(mktemp /tmp/foobar.$$.XXXXXXXXXX)
```

This creates a temporary file and assigns its name to the variable `tempfile`.
The `X` characters in the template are replaced with random letters and numbers
so that the final filename might be something like this:

```bash
/tmp/foobar.6593.UOZuvM6654
```

For scripts that are executed by regular users, it may be wise to avoid the use
of `/tmp` and create a directory within the user's home directory:

```bash
[[ -d $HOME/tmp ]] || mkdir $HOME/tmp
```

### Asynchronous Execution

It is often desirable to run multiple tasks (asynchronous execution) at the
same time, `bash` has the built-in command `wait` that causes a parent script
to pause until a specified process finishes:

Parent:

```bash
# async-parent: Asynchronous execution demo (parent) 

echo "Parent: starting..." 

echo "Parent: launching child script..." 
async-child & 
pid=$! 
echo "Parent: child (PID= $pid) launched." 

echo "Parent: continuing..." 
sleep 2 

echo "Parent: pausing to wait for child to finish..." 
wait "$pid" 

echo "Parent: child is finished. Continuing..." 
echo "Parent: parent is done. Exiting."
```

Child:

```bash
# async-child: Asynchronous execution demo (child)

echo "Child: child is running..." 
sleep 5 
echo "Child: child is done. Exiting."
```

In the parent script, the child script is launched and put into the background.
The process ID of the child script is recorded by assigning `pid` with the
value of `$!`, which always contains the process ID of the last job put into
the background.

The parent script continues and then executes `wait` with the PID of the child
process. This causes the parent script to pause until the child script exits,
at which point the parent script concludes.

The output:

```bash
Parent: starting... 
Parent: launching child script... 
Parent: child (PID= 6741) launched. 
Parent: continuing... 
Child: child is running... 
Parent: pausing to wait for child to finish... 
Child: child is done. Exiting. 
Parent: child is finished. Continuing... 
Parent: parent is done. Exiting.
```

### Named Pipes

Names pipes are a special kind of file and are used to create a connection
between two processes.

Named pipes behave like files but actually form first-in first-out (FIFO)
buffers. As with ordinary (unnamed) pipes, data goes in one end and emerges out
the other. With named pipes, it is possible to set up something like this:

```bash
process1 > named_pipe
process2 < named_pipe
```

and it will behave like this:

```bash
process1 | process2
```

To create a named pipe:

```bash
mkfifo pipe1
# $ ls -l pipe1
# prw-r--r-- 1 me   me    0 2009-07-17 06:41 pipe1
```

To demonstrate, open two terminal windows, in the first one:

```bash
ls -l > pipe1
```

In the second one:

```bash
cat < pipe1
```

The result of the command ran in the first terminal appears in the second!
