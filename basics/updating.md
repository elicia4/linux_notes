# Installing Updates

Notes taken on the "Linux Crash Course - Installing Updates" video by
LearnLinuxTV.

[***go back to README***](/README.md)  

You will learn how to install updates on Ubuntu, CentOS, and Arch. All (or
most) distributions based off of them have the same process. Even though they 
all use different commands to install updates, they have the same design to how
the process works. 

There is an index on you machine that you want to synchronize with the remote
server. When you use a package manager on Linux, you call software from a
remote server, but you first have to update the index so that the packages you
have listed locally as being available are actually available on the remote
server. If you don't do this first, you will encounter errors, they will say
that some packages aren't available. 

You have to update the package index first.

### Ubuntu (and all other Debian-based distros)

To update the index:

    sudo apt update

To upgrade the packages:

    sudo apt dist-upgrade

After installing all the updates (especially if you updated the kernel or some
other fundumental software), it's recommended that you reboot:

    sudo reboot

### CentOS (and anything based off RedHat)

There's a chance that your package manager on CentOS is actually `yum` and not
`dnf`. It means that you're using an older version of CentOS.

To update the packages (the index is updated automatically):

    sudo dnf update

Reboot:

    sudo reboot

### Arch (and Arch-based distros)

To synchronize the index and update:

    pacman -Syyu

Reboot:

    sudo reboot
