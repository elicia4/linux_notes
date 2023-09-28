# The `dnf` command

Notes taken on the "Linux Crash Course - The dnf Command" video by
LearnLinuxTV: https://youtu.be/oPEnvuj9QrI

[***go back to README***](/README.md)  

`dnf` is a package manager, it can be found in Fedora, CentOS, RedHat, Rocky and
so on.

A package manager is a command line utility that fetches software from a remote
repository. 

Let's install `htop`:

    sudo dnf install htop

Press `y`, you can just skip through here like in other package managers
because the default option here is `N`(no). After it completes, test `htop`:

    htop

To search for a package:

    dnf search apache

You get lots of results, the name is in front of the name of the architecture
of the package(`.x86_64`), you can install Apache now:

    sudo dnf install httpd

To list installed packages:

    dnf list installed

It will list both automatically and manually installed packages. 

To list packages that have been recently updated in the repositories:

    dnf list recent

A repository is the server where the the software comes from.

You can install more than one package at a time:

    sudo dnf install alacritty ulauncher

To remove a package:

    sudo dnf remove htop

You can install more than one package at a time:

    sudo dnf remove alacritty ulauncher

To upgrade a package to the latest version, note that the dependancies are
upgraded as well:

    sudo dnf upgrade firefox

To update EVERYTHING:

    sudo dnf upgrade

Do it all the time, it improves security. You can set up automatic updates with
`dnf-automatic`:

    sudo dnf install dnf-automatic

Then make changes to the configuration:

    sudo vim /etc/dnf/automatic.conf

If you only want to do the security upgrades, change the `upgrade_type`
parameter to `security`. This is particularily good for servers. 

Let's say one of your packages is acting weird, you get errors all the time and
so on. Reinstalling a package might fix your problems:

    sudo dnf reinstall htop

To remove unused packages:

    sudo dnf autoremove
