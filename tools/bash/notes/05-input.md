# Reading Keyboard Input

[***Table of Contents***](./00-contents.md)

`read` reads a line from STDIN into a variable(s). You can also read a line
from a file with redirection.

```bash
read [-options] [variable...]
```

If no variable is supplied, the shell variable `REPLY` will contain the data.

It's possible to assign multiple values to multiple variables as well:

```bash
read v1 v2 v3
# if you input 1 2 3, the variables will be:
# v1 = '1', v2 = '2', v3 = '3'
# if you input 1, the variables will be:
# v1 = '1', v2 = '', v3 = ''
# if you input 1 2 3 4 5 6, the variables will be:
# v1 = '1', v2 = '2', v3 = '3 4 5 6'
```

`read` options:

- `-a array` - assign the input to array, starting with index zero.
- `-d delimiter` - the first character in the string delimiter is used to
indicate the end of input, rather than a newline character.
- `-e` - use Readline to handle input. This permits input editing in the same
manner as the command line.
- `-i string` - use string as a default reply if the user simply presses Enter.
Requires the -e option.
- `-n num` - read num characters of input, rather than an entire line.
- `-p prompt` - display a prompt for input using the string prompt.
- `-r` - raw mode. Do not interpret backslash characters as escapes.
- `-s` - silent mode. Do not echo characters to the display as they are typed.
This is useful when inputting passwords and other confidential information.
- `-t seconds` - timeout. Terminate input after seconds. `read` returns a
non-zero exit status if an input times out.
- `-u fd` - use input from file descriptor fd, rather than standard input.

### IFS

Normally, the shell performs word splitting on the input provided to `read`. As
we have seen, this means that multiple words separated by one or more spaces
become separate items on the input line and are assigned to separate variables
by `read`. This behavior is configured by a shell variable named `IFS`
(Internal Field Separator). The default value of IFS contains a space, a tab,
and a newline character, each of which will separate items from one another.

If you wanted to read a line from `/etc/passwd`, where the field separator is
`:`, you could do the following:

```bash
IFS=":" read user pw uid gid name home shell <<< "$(grep "^root:" /etc/passwd)"
echo $user $pw $uid $gid $name $home $shell
```

The shell allows one or more variable assignments before a command. These
assignments alter the environment exclusively for the command that follows.

The `<<<` operator indicates a here string. A here string is single string here
document.

We might wonder why this rather oblique method was chosen rather than this:

```bash
echo "$file_info" | IFS=":" read user pw uid gid name home shell
```

The reason is that you can't pipe `read`.

While the `read` command normally takes input from STDIN, you cannot do this:

```bash
echo "foo" | read
```

The command will appear to succeed, but `REPLY` will be empty. In bash (and
other shells such as sh), pipelines create subshells. These are copies of the
shell and its environment that are used to execute the command in the pipeline.
In our previous example, `read` is executed in a subshell.

Subshells in Unix-like systems create copies of the environment for the
processes to use while they execute. When the processes finishes, the copy of
the environment is destroyed. This means that a subshell can never alter the
environment of its parent process. `read` assigns variables, which then become
part of the environment. In the previous example, `read` assigns the value
`foo` to the variable `REPLY` in its subshell's environment, but when the
command exits, the subshell and its environment are destroyed, and the effect
of the assignment is lost.

### Validating Input

It's often mandatory to validate your input to avoid unexpected situations:

```bash
invalid_input () { 
    echo "Invalid input '$REPLY'" >&2 
    exit 1 
} 

read -p "Enter a single item > " 

# input is empty (invalid) 
[[ -z "$REPLY" ]] && invalid_input 

# input is multiple items (invalid) 
(( "$(echo "$REPLY" | wc -w)" > 1 )) && invalid_input
```

[***Next Note***](./06-while_until.md)
