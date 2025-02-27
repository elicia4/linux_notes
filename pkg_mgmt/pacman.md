# `pacman`

Notes taken on the "Linux Crash Course - The Pacman Command" video by
LearnLinuxTV: https://youtu.be/oPEnvuj9QrI

[***Table of Contents***](/README.md)  

Like many package managers, `pacman` fetches packages from online repositories
(online servers that store installable packages, online sources where you can
get software).

On your local system, you have an index that stores info about all the packages
that are available on the repository servers you've subscribed to. Every now
and then it's a good idea to refresh that cache:

```bash
pacman -Syy 
```

`-S` is the sync option, the first `y` causes `pacman` to refresh the package 
database, the second `y` forces it to refresh the local database cache even if 
it thinks it's up-to-date.

If a package is displayed as unavailable in `pacman` and you are sure that it's
not, it means that your index is stale, you have to refresh your index. 

Which servers in particular is `pacman` trying to connect to? What is it
synchronizing with? View the following file:

```bash
cat /etc/pacman.d/mirrorlist
```

This is where `pacman` is grabbing things from.

To install a package:

```bash
pacman -S htop
```

Try it:

```bash
htop
```

To remove a package:

```bash
pacman -R htop
```

Let's assume that you want to install `pygame`, the problem that it's not named
`pygame` in the Arch repositories. You can look for it on the ArchLinux website
(https://archlinux.org). But there's a faster to do it from the command line:

```bash
pacman -Ss pygame
```

It's called `python-pygame`. Install it if you want:

```bash
pacman -S pygame
```

You can install multiple packages:

```bash
pacman -S htop tmux python-pygame
```

To find orphan packages (packages you likely don't need anymore):

```bash
pacman -Qdt # this will display them with version numbers
pacman -Qdtq # this will display them without version numbers
```

You can remove them:

```bash
pacman -R $(pacman -Qdtq)
```

`-Q` means query, `-d` skips the dependency checks, `-t` limits the results to
orphaned packages. 

To update your system:

```bash
pacman -Syu
```

`-u` is for updates. 

To find a package containing a specific file:

```bash
pacman -F <filename>
```

### Mirrorlist Upgrade

You might sometimes need to upgrade the mirrorlist (e.g, if your updates stop
working):

To generate a new mirrorlist, go to: https://archlinux.org/mirrorlist/

Select your country, you can select multiple with `Ctrl`. You should probably
deselect `http`, this will limit your servers to secure ones, click on the `Use
mirror status` box, then `Generate List`. 

1. Make a backup of the existing list:

   ```bash
   cd /etc/pacman.d;
   sudo cp mirrorlist mirrorlist.bak
   ```

1. Empty out the original list:

   ```bash
   sudo truncate -s 0 mirrorlist
   ```

1. Copy the list from your browser and insert it into the `mirrorlist` file:

   ```bash
   sudo vim mirrorlist
   ```

1. Make sure to uncomment the items.
