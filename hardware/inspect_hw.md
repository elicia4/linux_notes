# Inspecting Hardware

Notes on [the "Linux Crash Course - Easy Terminal Commands for Inspecting
Hardware" video](https://www.youtube.com/watch?v=oGyJr-iUwt8) by LearnLinuxTV.

[***Table of Contents***](/README.md)  

There are GUI alternatives to these commands. Most distros have system
monitors, hardware info apps, and so on.

### USB

You can view your USB devices with:

```bash
lsusb
```

If one of your USB devices isn't working correctly, you can copy the line
containing the problematic device's name, paste and into your search engine and
type your distro name at the end. It's likely that your problem has already
been solved.

You can combine `watch` with the `lsusb`. By default `watch` runs the same
command every 2 seconds, the `-d` option highlights differences:

```bash
watch -d lsusb
```

The new lines will be highlighted, try inserting a new USB drive. 

You can see the information on your USB devices in a tree view:

```bash
lsusb -t
```

### PCI

To view devices connected to your PCI bus:

```bash
lspci
```

The search engine tip makes sense here too.

# Detailed Hardware Information with `lshw`

To get more information about your hardware:

```bash
sudo lshw
```

You should run it with `sudo`, otherwise the output may be incomplete. 

The output of the command is extensive and may be confusing to read (for me it
certainly is). You can generate the output in HTML format, to view it later
redirect the output to a file.

```bash
sudo lshw -html > hwinfo.html    
```

You can open the file in Firefox:

```bash
firefox hwinfo.html
```

This is especially helpful while working with others. You may want to attach to
a bug report.

To shorten the output of `lshw`:

```bash
sudo lshw -short
```

It may be the best option to run `lshw` with.

### CPU

To view CPU information:

```bash
lscpu
```

### Storage

Use:

```bash
lsblk # list block storage
```

Devices that have the "disk" type are hard drives. The "part" type refers to
partitions. 

You can use `lsblk` with watch in cases when you have to work with external
hard drives:

```bash
watch -d lsblk
```
