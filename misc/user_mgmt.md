# User Management

Notes on the video "Linux Crash Course - Managing Users" by LearnLinuxTV.

[***Table of Contents***](/README.md)  

User management is one of the most important tasks you should be capable of.

There are many ways to add users. Almost all Linux distros have access to the 
`useradd` command:

    sudo useradd username

To see what users you already have:

    ls -l /home

^This is not the best way to do it. There may be users (and there certainly
are) that don't have a home directory, but do exist. Take a look at the
`/etc/passwd` file:

    cat /etc/passwd 

It shows the lists of users. You can count how many users you have on your
system:

    cat /etc/passwd | wc -l # wc = word count

You can see a particular user's information with `grep`:

    cat /etc/passwd | grep neo
    # neo:x:1001:1001::/home/neo:/bin/bash

The first number (after `x`) refers to the user ID, or UID. The second number
is the group ID (GID).

Add a new user called `luffy`:

    sudo useradd luffy
    cat /etc/passwd | grep luffy

As you can see, `luffy` got a different ID from your other accounts.
Specifically, it got assigned the next available UID. 

Normal user accounts have user ID's >1000, while system accounts are usually
<1000. List the `home` directory:

    ls /home

There's no home directory for `luffy`. :(  
This differs from one distro to another, so it might exist on your end. Take a 
look at the `/etc/default/useradd` file:

    cat /etc/default/useradd

The file sets the defaults for `useradd`.

Tell the `useradd` command specifically what you want it to do. It's a good
idea to be explicit when it comes to Linux in general, include all the options.
That's especially true when you're writing scripts, since you want them to be
portable.

Let's try adding the user again, but with the home directory this time. But
that requires us to delete that user first:

    sudo userdel luffy
    cat /etc/passwd | grep luffy

^Be very careful with this. Now let's add it back with the home directory:

    sudo useradd -m luffy

The `-m` option adds the home directory. 

To change the password of a user you're currently logged in with:

    passwd

To change the password of another user:

    sudo passwd luffy

If you have access to `sudo`, you don't need to know a user's password to
change it, so it doesn't ask you about the user's password. 

You might need to create a system account to automate certain tasks (like a
report for your boss). The best way to do it is with a system user and a `cron`
job:

    sudo useradd -r sysuser
    # the -r option tells your system to create a system user

`sysuser`'s UID will be <1000, since it's a system user. Also, system users are
not shown on the login screen. 

Let's inspect the `/etc/passwd` more in depth. 
1. The first column is the username.
1. The second column refers to the password, it's `x`. It means that you have an
  encrypted password, that it's hashed.
1. The UID
1. The GID
1. The user information field
1. The user home directory
1. The default shell

The `/user/sbin/nologin` shell doesn't allow a system user to log in, even if
it's password is set.

There's also an `etc/shadow` file:

    sudo cat /etc/shadow

You will need `sudo` to view this file, unlike `/etc/passwd`.

- The second column contains the password hash. 
- The third column refers to the number of days since the Unix epoch(Jan 1st,
  1970) that the password was last changed. 
- The fourth refers to the number of days required to pass before the user is
  able to change their password
- The fifth refers to the number of days until a password change is required
- The sixth refers to the number of days until the user is reminded to change
  their password
- The number of days until a user's password gets locked
- The number of days until the account is disabled
