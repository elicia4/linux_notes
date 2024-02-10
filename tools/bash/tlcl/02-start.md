# Project Start

[***Table of Contents***](./00-contents.md)

We will build an HTML report generator script. Throughout the building process,
you will discover various shell features.

Here's the default HTML structure:

```bash
vim foo.html
```

```bash
<html>
    <head>
        <title>Page Title</title>
    </head>
    <body>
        Page body.
    </body>
</html>
```

You can view the file in your web browser:

```
file:///home/<username>/foo.html
```

Output this HTML file to STDOUT with a script:

```bash
vim ~/bin/sys_info_page
```

```bash
#!/bin/bash

# Program to output a system information page

echo "<html>"
echo "    <head>"
echo "        <title>Page Title</title>"
echo "    </head>"
echo "    <body>"
echo "        Page body."
echo "    </body>"
echo "</html>"
```

Save the file, make it executable, and run it:

```bash
chmod 755 ~/bin/sys_info_page
```

Redirect the output to a new file and display it with your web browser:

```bash
sys_info_page > sys_info_page.html
firefox sys_info_page.html
```

When writing scripts, *always strive for simplicity and clarity*. So make it
simpler, combine all `echo`s into one:

```bash
#!/bin/bash

# Program to output a system information page

echo "<html>"
    <head>
        <title>Page Title</title>
    </head>
    <body>
        Page body.
    </body>
</html>"
```

Add a little useful data to it, like a better title and a heading:

```bash
#!/bin/bash

# Program to output a system information page

echo "<html>
    <head>
        <title>System Information Report</title>
    </head>
    <body>
        <h1>System Information Report</h1>
    </body>
</html>"
```
### Variables and Constants

See how the title "System Information Report" repeats multiple times? It may be
useful to create a variable for it, it could make future maintanence of the
script easier in case you want to change it.

```bash
#!/bin/bash

# Program to output a system information page

title="System Information Report"

echo "<html>
    <head>
        <title>$title</title>
    </head>
    <body>
        <h1>$title</h1>
    </body>
</html>"
```

We created a variable named *title* and assigned the value "System Information
Report" to it. We then reference it with `$title`.

Whenever you invoke a non-existant variable, it gets created and assigned
nothing:

```bash
echo $non_existent_var
```

Variable names rules:
1. Variable names may consist of alnum chars and underscores
   1. *Spaces and punctuation symbols are not allowed*
1. The first letter should be either a letter or an underscore

A variable implies that the value changes over time, however, in this script,
`title` doesn't change and is used a constant, so it should be a constant. For
example, Pi should be a constant in geometric programs.

The shell does not distinguish between variables and constants. It conventional
to use uppercase names for constants and lowercase letters for variables:

```bash
PI=3.1415
radius=5
```

Modify your script to comply with the convention:

```bash
#!/bin/bash

# Program to output a system information page

TITLE="System Information Report For $HOSTNAME"

echo "<html>
    <head>
        <title>$TITLE</title>
    </head>
    <body>
        <h1>$TITLE</h1>
    </body>
</html>"
```

We also added the shell variable `HOSTNAME`, it's the network name for the
machine.

The shell provides a way to enforce the immutability of constants, through the
use of the `declare` builtin command with the `-r` (read-only) option. Had we
assigned `TITLE` this way:

```bash
declare -r TITLE="Page Title"
```

the shell would prevent any subsequent assignment to `TITLE`. This feature is
rarely used, but it exists for very formal scripts.

You can force the shell to restrict the assignment to integers by using the
declare command with the `-i` option, but this is rarely done as well.

There is a great variablity of ways you can assign strings to variables:

```bash
a=z                  # Assign the string "z" to variable a. 
b="a string"         # Embedded spaces must be within quotes. 
c="a string and $b"  # Other expansions such as variables can be expanded into
                     # the assignment. 
d="$(ls -l foo.txt)" # Results of a command. 
e=$((5 * 7))         # Arithmetic expansion.
f="\t\ta string\n"   # Escape sequences such as tabs and newlines.
```

Multiple variable assignments may be done on a single line:

```bash
a=5 b="a string"
```

You may encounter the following problem when working with variables:

```bash
filename="myfile"
touch "$filename"
mv "$filename" "$filename1"
# mv: missing destination file operand after `myfile' 
# Try `mv --help' for more information.
```

This attempt fails because the shell interprets the second argument of the `mv`
command as a new (and empty) variable. The problem can be overcome this way:

```bash
mv "$filename" "${filename}1"
```

By adding the surrounding braces, the shell no longer interprets the trailing
`1` as part of the variable name.

Add the time the report was generated to the script:

```bash
#!/bin/bash

# Program to output a system information page

TITLE="System Information Report For $HOSTNAME"
CURRENT_TIME="$(date +"%x %r %Z")" 
TIMESTAMP="Generated $CURRENT_TIME, by $USER" 

echo "<html>
    <head>
        <title>$TITLE</title>
    </head>
    <body>
        <h1>$TITLE</h1>
        <p>$TIMESTAMP</p>
    </body>
</html>"
```

### Here Documents

A here document is an additional form of I/O redirection in which we embed a
body of text into our script and feed it into the standard input of a command.
It works like this:

```bash
command << token
text
token
```

where `command` is the name of command that accepts standard input and `token`
is a string used to indicate the end of the embedded text. Here we’ll modify
our script to use a here document:

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
    </body> 
</html> 
_EOF_
```

Single and double quotes *within here documents* lose their special meaning to
the shell. 

Here documents can be used with any command that accepts standard input. In
this example, we use a here document to pass a series of commands to the ftp
program to retrieve a file from a remote FTP server:

```bash
#!/bin/bash 

# Script to retrieve a file via FTP 

FTP_SERVER=ftp.nl.debian.org 
FTP_PATH=/debian/dists/stretch/main/installer-amd64/current/images/

cdrom REMOTE_FILE=debian-cd_info.tar.gz 
ftp -n << _EOF_ 
open $FTP_SERVER 
user anonymous me@linuxbox 
cd $FTP_PATH 
hash 
get $REMOTE_FILE 
bye
_EOF_
ls -l "$REMOTE_FILE"
```

If we change the redirection operator from `<<` to `<<-`, the shell will ignore
leading *tab characters (**but not spaces**)* in the here document. This allows
a here document to be indented, which can improve readability:

```bash
#!/bin/bash 

# Script to retrieve a file via FTP 

FTP_SERVER=ftp.nl.debian.org 
FTP_PATH=/debian/dists/stretch/main/installer-amd64/current/images/
cdrom REMOTE_FILE=debian-cd_info.tar.gz 

ftp -n <<- _EOF_ 
    open $FTP_SERVER 
    user anonymous me@linuxbox 
    cd $FTP_PATH 
    hash 
    get $REMOTE_FILE 
    bye 
    _EOF_ 

ls -l "$REMOTE_FILE"
```

The `bash` man page includes a section entitled "HERE DOCUMENTS," which has a
full description of this feature.
