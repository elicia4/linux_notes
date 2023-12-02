# The `zypper` command

Notes taken on the "Linux Crash Course - The `zypper` Command" video by
LearnLinuxTV.

[***Table of Contents***](/README.md)

`zypper` is a package manager, it's specific to SUSE. 

To search for a package:

    zypper search thunderbird

To install a package:

    sudo zypper install MozillaThunderbird

If a package you need to install requires dependancies, you will be notified,
press `y` to confirm. Try to launch it just to check, it should be installed.

To remove a package:

    sudo zypper remove MozillaThunderbird

Confirm with `y`. It should be gone.

To list available updates:

    zypper list-updates 

To update a package:

    sudo zypper update cifs-utils

To update all packages:
    
    sudo zypper update

To view information about a package:

    zypper info MozillaThunderbird

You can lock a package so it won't updated (there are bugs in newer versions
for example):

    sudo zypper al MozillaThunderbird # al = add lock

To view locked packages:

    zypper ll # ll = list locks

To remove a lock:

    zypper rl MozillaThunderbird # rl = remove lock

### Tips from comments (@citywitt3202)

1. Zypper will install dependencies for you, but it won’t remove them
   automatically unless you add the `--clean-deps` flag after the remove
   keyword:

    sudo zypper install --clean-deps MozillaThunderbird

2. Update is good but if you’re on the rolling release you’ll want to use:

    zypper dup

As well as upgrading packages it performs a full distribution upgrade and
removes packages no longer needed.
