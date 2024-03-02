# 10 Typical Linux Problems

There are notes on [this video,](https://www.youtube.com/watch?v=xsdFNpThetE)
man pages, and other resources on the Internet.

[***Table of Contents***](/README.md)

### Can't Log In Via SSH

If you or somebody else can't log in to a server via ssh, it's not always
obvious what the underlying problem is.

1. Try connecting via ssh yourself. If you can, it means that ssh itself is
   working.
1. Read the authentification log / file that logs ssh failures:

   ```bash
   tail -f /var/log/auth.log # the file may be different on your distro
   ```

### No Space Left On Device

Whenever you create a file, you might get the `No space left on device`
error, but when you check (`df -h`), your disk isn't full. This most likely
has to do with [inodes](./inodes.md), so check inode usage:

```bash
df -i
```

A Linux installation has a limited number of inodes, every file takes up
one, so you have a finite number of files you can store on your system. This
number is astronomically high, so if you hit it, it probably has to do with
a fault in an application. This is especially true if you run a mail server.
You can solve this problem by searching for directories containing many
files:

```bash
du --inodes -xS | sort | head -n 25
```

### WiFi Doesn't Work

Live mode a distribution before you install it. If it doesn't work, don't
install it. In case it doesn't work on all of them, you should probably just
replace your WiFi card, they're usually very cheap (<15$). Before you buy a
WiFi card, make sure it can be installed in your computer, that is, the
computer itself can be opened and there's a WiFi card slot there and that the
computer is allowed to boot with an external (non-vendor) WiFi card. I would 
personally get an Intel card, in case you can't physically install it inside
your computer, you can get a USB WiFi card, for example from ThinkPenguin.

Alternatively, you find the driver, compile it, and install, it since some WiFi
cards don't contribute drivers upstream to the Linux kernel, but it's not a
good idea since it will break whenever you update and you will have to do it
again. 

### Machine Slow On GNOME For No Reason

If you machine is slow on GNOME, try disabling the Tracker indexing service
(file search application). It's a great tool, but it falls down whenever you
have network shares, since Tracker indexes them too, consuming lots of
resources. You can make Tracker ignore certain directories, including
mounted network shares. Go to whatever location you want to ignore and
create a `.trackerignore` file there:

```bash
cd /mnt/nas/dir
touch .trackerignore
```

### GNOME Apps Aren't Running

You try to open an application, and it doesn't open. Go to Settings > Region &
Language, make sure that your settings there are set appropriately. It's likely
that the locale settings are not set properly.

### Poor Gaming Performance

Normally, your video card are built-in into your distribution, but Nvidia has a
proprietary driver and they don't upstream that to Linux. As a result, you have
to install them manually.

Thankfully, many modern distributions have this functionality built into them.
Ubuntu has an "Additional Drivers" application, you can find available drivers
there.

### Extremely Erratic Behaviour

This is just vague. You get random errors and everything isn't running all that
well. This might have to do with defective memory chips, Linux doesn't handle
them that well. What you can do is test it with "MemTest86", it will report any
problems to you regarding your RAM.

### Hardware VS Software Problem

Hardware issues are usually obvious (i.e. breaking a monitor), but sometime you
just can't tell whether it's a hardware or a software problem.

Run Live media! Check if that problem repeats there or if it just happens on
the installed environment. If it doesn't, it's likely a software issue. If it
does, it's a hardware issue. 

Generally speaking, live media is something you should always have around, it
helps you troubleshoot things. Try checking if a problem persists on multiple
different distrubtions.

### Docking Stations With DisplayLink

DisplayLink is a technology that powers some docking stations (USB-C, USB 3
etc.). Operating systems know how to interface with hardware by themselves,
there's no need for the middle man, all OS's have built-in support for docking
stations. Just don't buy it, get a regular docking station.

### Specific Hardware Isn't Working

It could be the case that your distro isn't compatible with a specific piece of
hardware. More often than not, the problem is that you use an old Linux kernel.
The Linux kernel has drivers built into it, if you're using an old one, it
might not have appropriate support for drivers, it can't possibly understand
new hardware. Some distros ship with an older kernel, try to understand how old
your kernel is and how new your hardware is. Consider using PopOS or Ubuntu,
they have incredible hardware support.
