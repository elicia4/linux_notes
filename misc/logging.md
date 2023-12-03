# Understanding Logging

Notes taken on this video by LearnLinuxTV: https://youtu.be/6uP_f_z3CbM

[***Table of Contents***](/README.md)  

When you manage Linux servers, you want to know what's going on at any given
time: what's happening, what's connected to your servers, who's using your
servers etc. 

Using logs you can find out A LOT of information about your servers, there's a
log file for about every use case.

Different distros name logs differently. To show your OS info:

    cat /etc/os-release

It's quite common that log files are located in the `/var/log` directory. A lot
of the files in that directory end with `.log`, but not all of them do. There
really is no consistency as to how these files are named. 

### Fedora 

On the Fedora distro, there's a file called `boot.log`, it pertains to the boot
process. To take a look at a log file, you might have to use `sudo`, viewing
log files as root is quite common. It's useful to analyze `boot.log` when you
troubleshoot the boot process, since you can't really see the messages when the
actual boot process is happening.

Another log file that is specific to Fedora is the `dnf.log` file. It allows us
to look at the history of the packages that were recently installed on the
server.

Let's now take a look at the `wtmp` file. You won't be able to see it's
contents with the `cat wtmp` command, it will just show you funny characters.
`wtmp` is what is known as a binary log. If you can't see it, it generally
means that there is some other command that allows you to view it. In this
case, the command is:

    last 

This file gives you details of all the login/logout events, so if you wanted to
audit the users that are logging into your server you're in the right place.

The same thing is true of the `btmp` file as well. To view it, use:

    sudo lastb 

The *b* in `lastb` stands for "bad", so if you only wanted to view bad login
attempts, use `lastb`. If somebody is trying to break into your server, you
probably don't care about the successful login attempts, that's when the `btmp`
file is useful.

Let's try using `lastb` with some options now:

    sudo lastb -adF 

- `-a` shows the hostname in the last column;
- `-d` attempts to match DNS names to IP addresses (which is something that may
  be useful);
- `-F` gives the full times for the times that are shown from this command.

### Ubuntu

Now let's take a look at log files on Ubuntu. A few log files are the same as
in Fedora, but most of them are actually different. Fedora logs are relativily
similiar to log files on CentOS, Red Hat, AlmaLinux, Rocky Linux, basically any
distro that is based on the Red Hat family. The same thing is true of the
Debian-based Linux distros (Ubuntu is a Debian-based distro). There's a lot of
overlap when it comes to distribution family. 

Let's check out `auth.log` (short for authorization log), it contains login
attempts, it's useful for troubleshooting. Let's learn tail follow with the
help of this file. When you have a text file, you can follow the contents of
that log file and see the output show up on your screen as soon as anything is
added to that log file.

    sudo tail -f /var/log/auth.log 

The tail command gives you the last portion of a text file. If an on another
computer an attempt is made to connect to your computer, you will see new
messages come up. You will see exactly what happens, whether the other user
made a password mistake while trying to connect. 

Take notice of the `auth.log` file, if you have an authorization problem you
might want to take a look at it.

There's another important file called `syslog` (system log). It's used system
events, if you're troubleshooting hardware issues, you might want to take a look
at this file. Tail this file if you're having USB-related issues.

On the Ubuntu system the `apt` package manager is used, for storing apt-related
logs there is a directory called "apt". `cat` the `history.log` file, it
contains a lot of information regarding the use of the package manager. If
something related to packages is not working quite right, check this file out. 

The `dmesg` log file also shows system-related events, just like `syslog`, but
a bit differently, for instance it uses a different format for time. You'll see
different information there, especially hardware-related information, since this
is a kernel log file. There's actually a separate command to view the contents
of `dmesg`:

    sudo dmesg 

### journalctl

Now let's take a look at the `journalctl` command. It's specific to `systemd`.
It allows us to inspect units on the system and view the log files that pertain
to those services. To use it:

    journalctl -u <service>

For example:

    journalctl -u ssh

There's also a follow mode of `journalctl`:

    journalctl -fu ssh

Display system messages:

    journalctl -b # current boot
    journalctl -b 0 # the same
    journalctl -b -1 # previouse boot

Search the current boot messages for regular expression:

    journalctl -b -g 'pattern'

Display messages by priority:

    journalctl -b  -p0..0 # emerg
    journalctl -b  -p1..1 # alert
    journalctl -b  -p0..2 # emerg thru critical
    journalctl -b  -p2     # the same

These are the basics of logging. (:
