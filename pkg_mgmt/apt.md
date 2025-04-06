# `apt`

Notes taken on the "Linux Crash Course - The apt Command" video by
LearnLinuxTV.

[***Table of Contents***](/README.md)  

`apt` is a package manager on many popular distros (Debian, Ubuntu, Mint and so
on). Debian is where it all started.

Any time you use `apt`, you should refresh it and make sure it's up-to-date:

```bash
sudo apt update
```

This command refreshes your local package index. Let's install `tmux`:

```bash
sudo apt install tmux
```

It will install all dependencies as well. You can install multiple packages
with one command:

```bash
sudo apt install tmux htop git
```

To remove an application:
    
```bash
sudo apt remove htop
```

To remove an application AND its configuration files:

```bash
sudo apt purge htop
```

What if you don't know the name of the package you want to install?

```bash
sudo apt search vim
```

To update your system:

```bash
sudo apt update && sudo apt dist-upgrade
```

There's a difference between `dist-upgrade` and `upgrade`, `dist-upgrade` will
install upgrades that require the installation of additional packages or the
removal of packages.

How do distros know where to get their upgrades from? It has a list of sources
it pulls its updates from. The sources are stored inside the
`/etc/apt/sources.list`:

```bash
vim /etc/apt/sources.list
```

Be careful, if you make a mistake in this file you won't be able to install
packages. To include non-free packages (which are hidden by default), add
`non-free` to the end of the first line that starts with `deb`. Any time you
make changes to the file, run `sudo apt update` to refresh the index to include
new packages from the repository you've just added or the category you've just
added.

TIP: You can show more info about a package:

```bash
apt show <package>
```

To find a package containing a specific file, use `apt-file`:

```bash
sudo apt install apt-file # install it
sudo apt-file update      # update its database
sudo apt-file update      # search for the file
```
