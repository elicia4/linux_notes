# Understanding Logging

Notes taken on this video by LearnLinuxTV: https://youtu.be/6uP_f_z3CbM

[***go back to README***](README.md)  

When you manage Linux servers, you want to know what's going on at any given
time: what's happening, what's connected to your servers, who's using your
servers etc. 

Using logs you can find out A LOT of information about your servers, there's a
log file for about every use case.

Different distros name logs differently. To show your OS info:

    cat /etc/os-release

It's quite common that log files are located in the `/var/log` directory. A lot
of the files in that directory end with `.log`, but not all of them do. There 
really is no consistency as to how these files are named. On the Fedora distro,
there's a file called `boot.log`, it pertains to the boot process. To take a 
look at a log file, you might have to use `sudo`, viewing log files as root is
quite common. It's useful to analyze `boot.log` when you troubleshoot the boot
process, since you can't really see the messages when the actual boot process
is happening.

Another log file that is specific to Fedora is the `dnf.log` file. It allows us
to look at the history of the packages that were recently installed on the 
server.

Let's now take a look at the `wtmp` file. You won't be able to see it's
contents with the `cat wtmp` command, it will just show you funny characters.
`wtmp` is what is known as a binary log. If you can't see it, it generally
means that there is some other command that allows you to view it. In this
case, the command is:

    ```
    last
    ```
This file gives you details of all the login/logout events, so if you wanted to
audit the users that are logging into your server you're in the right place.

The same thing is true of the `btmp` file as well. To view it, use:

    ```
    sudo lastb
    ```

The *b* in `lastb` stands for "bad", so if you only wanted to view bad login
attempts, use `lastb`. If somebody is trying to break into your server, you
probably don't care about the successful login attempts, that's when the `btmp`
file is useful.
