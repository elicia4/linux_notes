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
