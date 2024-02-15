# Linux File Types

These are notes on [this video](https://www.youtube.com/watch?v=EDgkcvOoY8A) by
tutoriaLinux.

[***Table of Contents***](/README.md)  

Everything that happens in Linux is done through the file system, whether it's
devices, network connections or kernel information about the running processes.
The common interface is always the file system.

There are regular files and directories. You can see the file type by looking
up a file's permission bits:

```bash
ls -l <file>
ls -ld <file> # for directories
```

- `-` is a regular file;
- `d` is a directory file. Directories are references to the names of other
  files;
- `l` is a link file;
- `b` is a block special device file. Anything that can store information will
  give you blocks. It indicates this "thing" has some storage blocks that you
  can write to, it stands for a virtual or physical device;
- `c` is a character device file, for example your mouse or your keyboard.
  Terminals (`/dev/ttys0`) and serials ports are also character devices.
- `p` is a named pipe file;
- `s` is a local socket file, it passes information between programs. It only
  opens to parties of that communication.

A device file is the meeting point between the kernel and the firmware. For
example, `/dev/sda` is a place where the driver from the Linux side
communicates with the hardware itself, or the firmware.

A mouse character file is where the mouse writes information and where the OS
picks up that information and does something with it.

Block devices buffer on the kernel, the kernel stores memory that the device
can access, whereas character files go straight to the device.
