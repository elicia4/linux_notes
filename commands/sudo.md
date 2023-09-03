# `sudo`

Notes taken on this video by LearnLinuxTV: https://youtu.be/07JOqKOBRnU

[***go back to README***](/README.md)  

There are many commands that you can only use with root priveleges. `sudo` is
something you can use instead of root. If, for instance, you were logged in as a
local user and wanted to update your system with `apt update`, you wouldn't be
able to do it. 

To change to the root account:

    su -

Note that not all systems have the root account enabled. But you can get by by
not using the root account at all by using `sudo`, if you have it properly set
up you can lock root out. You shouldn't have the root account enabled for `ssh`
login.

To find out if you have `sudo` installed:

    which sudo

Find out what your `sudo` group is on your distribution. Usually it's named
`sudo` or `wheel`. The `sudoers` file contains that information:

    # if you don't have sudo set up, you will have to switch to root
    su -
    cat /etc/passwd

    # if sudo already exists on your system
    sudo cat /etc/passwd

Find the following lines in the config:

    # Allow members of group sudo to execute any commands
    %sudo  ALL=(ALL:ALL) ALL

It can be `wheel` instead of `sudo`.

To add a user to the `sudo` group:

    usermod -aG sudo user

To view groups of a local user account:

    groups

To see which permissions you have access to:

    sudo -l

If you have 3 `ALL`'s, you have permission to do anything.

What do you do when you forget to use `sudo` all he time? Start using:

    # !! represents your last command
    sudo !!

Now let's take a look at the `/etc/sudoers` file. There are configurations for
the root user and various `sudo` groups. You can create a new group that has
access to sudo by copying the `%sudo ...` line and changing the name from `sudo`
to something else.

What to the `ALL`'s mean? The first `ALL` refers to the host/server that you are
allowed to execute the commands on. The `ALL`'s in parentheses pertain to the
users that have access to execute commands, by default `sudo` impersonates
`root`. The first `ALL` refers to the user you're allowed to impersonate, the 
second refers to the group, the last refers to the commands a user is allowed to
use with `sudo`.

Note that you shouldn't edit the file with a "normal" editor, you can break the
strict formatting and lock yourself out of using the server. There's a special
command that allows you to edit the file:

    sudo visudo 

Add a new line to the `User privilege specification`:

    user   ALL=(ALL:ALL) ALL

Now save and exit the file, it you made any mistakes, `visudo` will tell you :)

You can create a `user` account if you don't have it already:

    sudo adduser user

To switch to `user`:

    sudo su - user

Again, to see what it can do:

    sudo -l

...but you want to be more restrictive with `sudo`. Let's restrict `user` to be
able to do one specific thing:

    user   ALL=(ALL:ALL) /usr/bin/apt

If you run `apt` now from the `user` account, it will work, but other commands,
like `reboot`, won't. You can add other commands like so:

    user   ALL=(ALL:ALL) /usr/bin/apt,/usr/bin/rm

You can set up `sudo` to not need a password:

    user   ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt,/usr/bin/rm

Note that this lowers your security. 

If you make a mistake, you will be prompted with:

    >>> /etc/sudoers: syntax error near line 21 <<<
    What now?

It doesn't tell you what exactly to do. 

- to edit the file, enter `e`. 
- to exit without saving changes, enter `x`.
- to save the changes **with the mistakes** (never really do this), enter `q`.

These are the basics :)
