# The Arch User Repository (AUR)

Notes taken on the "Linux Crash Course - The Arch User Repository (AUR)" video
by LearnLinuxTV

[***Table of Contents***](/README.md)

Take a look at the 2 tips of the bottom, the simplify the process quite a bit
(thanks @SkySumisu).

If you're looking for a package and it's not available in the main
repositories, AUR will help you.

Let's install a package from the AUR, for instance Google Chrome. It doesn't
exactly matter which package you install, the process is similiar (if not the
same) for most packages.

The website of AUR is:

```bash
https://aur.archlinux.org
```

In the top right, you can see a search bar, look for Google Chrome there. On
the main ArchLinux site (https://archlinux.org) it's not available. On the AUR,
it is. If in the future you experience a problem with a package, check out the 
comments on the package page. Anyways, after you get on the package page on the
AUR, copy the link location of `Download snapshot` on the right. Download it:

```bash
wget <link>
```

You should now have a `.tar.gz` file inside your current directory. To unpack
it:

```bash
tar -xvf google-chrome.tar.gz
```

Go inside the `google-chrome` directory. Before you build the package, it's a
good idea to look at the `PKGBUILD` file and see what it's doing:

```bash
vim PKGBUILD
```

If you see something terrible (like `rm -rf /`) inside your package build, you
should not install it. It is probably never the case, but it's a good idea to
get into the mindset of always reading a script before executing it (or at
least skimming through it).

To build you might want to install a few dependancies first:

```bash
pacman -S base-devel
```

To build:

```bash
makepkg -s # -s installs missing dependancies
```

It's provided by `pacman` automatically, it should be available on your system.
Once the building process is finished, there should be a `.zst` file available,
it's a package file, you should be able to install that:

```bash
pacman -U google-chrome-117.0.5938.88-1-x86_64.pkg.tar.zst
```

Now it's installed. 

But this was the difficult path to get packages from AUR, a better way is to
use `yay`. You should have `git` on your system to install `yay`:

```bash
pacman -S git
```

To install `yay`:

```bash
git clone https://aur.archlinux.org/yay.git
```

Build it:

```bash
makepkg -s
```

You can update your entire system and all the AUR packages you have:

```bash
yay -Syu
```

TIP: To build AND install at the same time:

```bash
makepkg -si
```

TIP: You can click on the link next to the `Git Clone URL:` to copy it and then
use `git clone` to download it. You don't have to use `wget`:

```bash
git clone https://aur.archlinux.org/google-chrome.git
```
