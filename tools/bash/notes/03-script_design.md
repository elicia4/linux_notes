# Script Design

[***Table of Contents***](./00-contents.md)

Break down large, complicated tasks into simple tasks, and break those down
ever further until the entire process has been fully defined.

This process of identifying the top-level steps and developing increasingly
detailed views of those steps is called *top-down design*.

Currently, your script consists of the following steps:

1. Open page.
2. Open page header.
3. Set page title.
4. Close page header.
5. Open page body.
6. Output page heading.
7. Output timestamp.
8. Close page body.
9. Close page.

Add the following steps between step 7 and 8:

- System uptime and load, the amount of time since the last shutdown or reboot
  and the average number of tasks currently running on the processor over
  several time intervals.
- Disk space, the overall use of space on the system’s storage devices.
- Home space, the amount of storage space being used by each user.

If you had a command for each of these tasks, they could be implemented like
so:

```bash
#!/bin/bash 

# Program to output a system information page 

TITLE="System Information Report For $HOSTNAME" 
CURRENT_TIME="$(date +"%x %r %Z")" 
TIMESTAMP="Generated $CURRENT_TIME, by $USER" 

cat << _EOF_ 
<html> 
    <head> 
        <title>$TITLE</title> 
    </head> 
    <body> 
        <h1>$TITLE</h1> 
        <p>$TIMESTAMP</p> 
        $(report_uptime)    
        $(report_disk_space)
        $(report_home_space)
    </body> 
</html> 
_EOF_
```

`$(report_uptime)`, `$(report_disk_space)`, and `$(report_home_space)` could be
implemented with new scripts or you could embed them into the current script
with shell functions. Functions can be defined in two ways, a formal one:
```bash
function name {
    commands
    return
}
```

...or a simpler one:
```bash
name () {
    commands
    return
}
```

`return` terminates the function and returns control to the program. Shell
function definitions must appear in the script before they are called in order
to be interpreted correctly. Add minimal function definitions to the script:

```bash
#!/bin/bash 

# Program to output a system information page 

TITLE="System Information Report For $HOSTNAME" 
CURRENT_TIME="$(date +"%x %r %Z")" 
TIMESTAMP="Generated $CURRENT_TIME, by $USER" 

report_uptime() {
    return
}

report_disk_space() {
    return
}

report_home_space() {
    return
}

cat << _EOF_ 
<html> 
    <head> 
        <title>$TITLE</title> 
    </head> 
    <body> 
        <h1>$TITLE</h1> 
        <p>$TIMESTAMP</p> 
        $(report_uptime)    
        $(report_disk_space)
        $(report_home_space)
    </body> 
</html> 
_EOF_
```

A function must contain at least one command, a `return` is enough.

### Local Variables

All the variables previously mentioned have been *global variables*, they exist
throughout the program.

Local variables, those defined in functions, can only be accessed within shell
functions and cease to exist after function termination. Having  local
variables allows the programmer to use variables with names that already exist,
without having to worry about potential name conflicts. For example:

```bash
#!/bin/bash 

# local-vars: script to demonstrate local variables 

foo=0 # global variable foo 

funct_1 () { 
    local foo # variable foo local to funct_1 

    foo=1
    echo "funct_1: foo = $foo"
}

echo "global:  foo = $foo" 
funct_1 
echo "global:  foo = $foo" 
```

The assignment of a value to the local variable `foo` has no effect on the
value of `foo` defined globally. This is really useful, since it allows
functions to remain independent of each other and of the main script itself,
thus preventing parts of the program from interfering with each other. By using
local variables, you also make your functions portable, you can paste them into
other scripts without worrying about breaking something.

### Test Your Scripts Frequently

By doing so, you can detect potential problems early on, making the debugging
process a lot easier.

By adding empty functions, called *stubs*, you can verify the logical flow of
your program at an early stage. When creating a stub, it's a good idea to
include something that provides feedback.

In it's current state, your script produces the following output:

```html
<html>
    <head>
        <title>System Information Report For hostname</title>
    </head>
    <body>
        <h1>System Information Report For hostname</h1>
        <p>Generated 02/10/2024 11:04:48 AM XDD, by user</p>



    </body>
</html>
```

Empty lines in your script are not descriptive enough. Make some changes to the
functions to make the output more descriptive:

```bash
report_uptime () { 
    echo "Function report_uptime executed." 
    return 
} 

report_disk_space () { 
    echo "Function report_disk_space executed." 
    return 
} 

report_home_space () { 
    echo "Function report_home_space executed." 
    return 
}
```

Now you get:

```html
<html>
    <head>
        <title>System Information Report For hostname</title>
    </head>
    <body>
        <h1>System Information Report For hostname</h1>
        <p>Generated 02/10/2024 11:07:14 AM XDD, by user</p>
        Function report_uptime executed.
        Function report_disk_space executed.
        Function report_home_space executed.
    </body>
</html>
```

Now you see that your three functions ran. Now create the functions properly:

```bash
report_uptime () { 
    cat <<- _EOF_ 
        <h2>System Uptime</h2> 
        <pre>$(uptime)</pre> 
        _EOF_ 
    return 
}

report_disk_space () { 
    cat <<- _EOF_ 
        <h2>Disk Space Utilization</h2> 
        <pre>$(df -h)</pre> 
        _EOF_ 
    return 
}

report_home_space () { 
    cat <<- _EOF_ 
        <h2>Home Space Utilization</h2> 
        <pre>$(du -sh /home/*)</pre> 
        _EOF_ 
    return 
}
```

`<pre>` tags are used to preserve the formatting of the command.

*Make sure* you indent the `_EOF_` markers with tab characters, you can insert
them in `vim` by pressing `CTRL-V` + `Tab` in insert mode, otherwise you will
get the `syntax error: unexpected end of file`.

Note that `du -sh` won't work on many systems, since they set home directories
to be unreadable by world. This can be solved by adjusting the behaviour of the
script based on the priveleges of the executing user.

### Shell Functions in `.bashrc`

Shell functions can be put into the `.bashrc` and be used just like aliases.
