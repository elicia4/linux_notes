# The `head` and `tail` commands

Notes taken on the "Linux Crash Course - The `head` and `tail` Commands" video
by LearnLinuxTV.

[***Table of Contents***](/README.md)

The `head` commands shows the first 10 commands of a file, and the `tail`
command shows the last 10 commands of a file:
    
    head /var/log/syslog; tail /var/log/syslog;

You should probably copy the `syslog` file first:

    cp /var/log/syslog .

To see how many lines you have in your `syslog` file:

    cat /var/log/syslog | wc -l

To show a specific number of lines use `-n`:

    head -n 25 syslog; tail -n 25 syslog;
    
Let's view the first 10 lines containing `ssh` in `syslog`:

    cat syslog | grep ssh | head

There's a specific option of the `tail` command, you can follow a log file
live, while it's being changed:
    
    tail -f /var/log/syslog

Execute a command in another terminal window to see changes happening in the
`syslog` file, for example:

    sudo systemctl restart ssh

It's updating in near-real time, it's not perfect. 

It's also a good idea to check the authorization log file sometimes
(`auth.log`):

    tail -f /var/log/auth.log
    
To easily differentiate, add some line breaks (press `Enter` a couple of times)
in the `tail`ing window so that you can clearly see the new output when it
appears.

The `tail -f` command is essential for troubleshooting, memorize it.
