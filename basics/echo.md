# The `echo` command

Notes taken on the "Linux Crash Course - The echo Command" video by
Learn Linux TV.

[***Table of Contents***](/README.md)  

The basic usage of `echo`:

    echo "Hello, World!"

Another useful usage is to print out the contents of a variable:

    msg="Hello, World";
    echo $msg;

You have quite a few variables in your session that are created for you:

    env

Print one of them out:

    echo $HOME


You can sound an alert with `echo`:

    echo -e "\aHello World"

The `-e` enables interpretation of backslash escapes. This didn't work for me,
but the `\a` escape is supposed to produce a sound. There are other escapes 
available:

    echo -e "This is a\bLinux Server"

You can abandon text with `\c`:

    echo -e "This is a\cLinux Server"
    
To create a new line:

    echo -e "This is a\nLinux Server"

You can redirect `echo` output to a text file:

    echo "Logfile started: $(date +'%D %T')" > log.txt;

The `+'%D %T'` parameters output the date and the time.

Check it out:

    ls;
    cat log.txt

The `-n` option suppresses the output of the newline character at the end. This
option is comes in handy whenever you have to create input prompts:

```bash
echo -n "Please enter a number: "; read num; echo $num;
```
