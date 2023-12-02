# Hostname

Notes on the video "Linux Crash Course - Setting the Hostname of your Linux
Workstation or Server" by LearnLinuxTV.

[***Table of Contents***](/README.md)  

Depending on how you have your shell configured, the hostname of your machine 
will be displayed right in the bash prompt. In case it's not, to display it:

    hostname

To see where it's stored, take a look at the `/etc/hostname` file:

    cat /etc/hostname

Let's take a look at a special command:

    hostnamectl

By itself, it will give you some system information. This same command is used
to change the hostname as well:

    sudo hostnamectl set-hostname new_hostname

It won't be displayed immediately since your terminal window was opened before
you changed the hostname. You can relaunch it or open a new tab to see a new
one in the prompt, or just force it along:

    exec bash

Take a look at the `/etc/hostname` file again to confirm:

    cat /etc/hostname

You can change it to a domain too:

    sudo hostnamectl set-hostname new-hostname.domain.com

Take a look at the `/etc/hosts` file, it might not have updated. You can update
it manually:

    sudo vim /etc/hosts

Add a new line:

    127.0.1.1  newhostname

^ Do this is if it's only just a hostname. If you have a domain, type that
there as well and a shortened version like so:

    127.0.1.1  newhostname.domain.com newhostname

You should be able to ping the domain name now:

    ping newhostname.domain.com 

...and the shortened name too:

    ping newhostname 
