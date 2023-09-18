# Hardware

Notes on the video "Linux Crash Course - Easy Terminal Commands for Inspecting Hardware" by LearnLinuxTV.

[***go back to README***](/README.md)  

There are GUI alternatives to these commands. Most distros have system
monitors, hardware info apps, and so on.

### USB

You can view your USB devices with:

    lsusb

If one of your USB devices isn't working correctly, you can copy the line
containing the problematic device's name, paste and into your search engine and
type your distro name at the end. It's likely that your problem has already
been solved.

You can combine the `watch` command with the `lsusb`. By default the `watch`
command runs the same command every 2 seconds, the `-d` option highlights
differences:

    watch -d lsusb

The new lines will be highlighted, try inserting a new USB drive. 

You can see the information on your USB devices in a tree view:

    lsusb -t

### PCI

To view devices connected to your PCI bus:

    lspci

The search engine tip makes sense here too.

To get more information about your hardware:

    sudo lshw

You should run it with `sudo`, otherwise the output may be incomplete. 

The output of the command is extensive and may be confusing to read (for me it
certainly is). You can generate the output in HTML format, to view it later
redirect the output to a file.

    sudo lshw -html > hwinfo.html    

You can open the file in Firefox:

    firefox hwinfo.html

This is especially helpful while working with others. You may want to attach to
a bug report.

To shorten the output of `lshw`:

    sudo lshw -short

It may be the best option to run `lshw` with.

### CPU

To view CPU information:

    lscpu

### Storage

Use:

    lsblk # list block storage

(oversimplified) Block storage devices are hard drives. Devices that have the
"disk" type are hard drives. The "part" type refers to partitions. 

You can use `lsblk` with watch in cases when you have to work with external
hard drives:

    watch -d lsblk
