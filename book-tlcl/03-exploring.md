# Exploring the System

- `file` – determine file type
- `less` – view file contents

You can list multiple directories with `ls`:

``` ls <dir-1> <dir-2> <...> ```

- `-t` - sort the result by the file's modification time.
- `-r` `--reverse` - reverse the order of the sort,
- `-A` `--almost-all` - like the `-a` option above except it does not list `.`
  (current directory) and `..` (parent directory).
- `-d` `--directory` - use this option in conjunction with the `-l` option to
  see details about the directory rather than its contents.
- `-F` `--classify` - this option will append an indicator character to the end
  of each listed name. For example, a forward slash (`/`) if the name is a
  directory.
- `-S` - sort results by file size.

The second field in the `ls -l` output indicates the number of hard links:

> -rw-r--r-- 1 root root 3576296 2017-04-03 11:05 Experience ubuntu.ogg

`less` falls into the class of programs called “pagers,” programs that allow
the easy viewing of long text documents in a page by page manner. 

`less` hotkeys:

- `Page Up` or `b` - scroll back one page;
- `Page Down` or `space` - scroll forward one page;
- `Up arrow` - scroll up one line;
- `Down arrow` - scroll down one line;
- `G` - move to the end of the text file;
- `1G` or `g` - move to the beginning of the text file;
- `/characters` - search forward to the next occurrence of characters;
- `n` - search for the next occurrence of the previous search;
- `h` - display help screen;
- `q` - quit less.

Note: find an alternative to `less` but with `vim` hotkeys.

## The File System

The file system layout design is specified in the ***Linux Filesystem Hierarchy
Standard***. 

Directories found on Linux systems:

- `/` is the root directory. Where everything begins.
- `/bin` contains binaries (programs) that must be present for the system to
  boot and run.
- `/boot` contains the Linux kernel, initial RAM disk image (for drivers needed
  at boot time), and the boot loader.  Interesting files:
  - `/boot/grub/grub.conf` or `menu.lst`, which are used to configure the boot
    loader.
  - `/boot/vmlinuz` (or something similar), the Linux kernel.
  - `/dev` is a special directory that contains device nodes. “Everything is a
    file” also applies to devices. Here is where the kernel maintains a list of
    all the devices it understands.
- `/etc` contains all of the system-wide configuration files. It also contains
  a collection of shell scripts that start each of the system services at boot
  time.  
  Everything in this directory should be readable text. Interesting files:  
  While everything in `/etc` is interesting, here are some all-time favorites:
  - `/etc/crontab`, a file that defines when automated jobs will run.
  - `/etc/fstab`, a table of storage devices and their associated mount
    points.
  - `/etc/passwd`, a list of the user accounts.
- `/home` - in normal configurations, each user is given a directory in `/home`.
  Ordinary users can only write files in their home directories. 
- `/lost+found` - each formatted partition or device using a Linux file system,
  such as `ext4`, will have this directory. It is used in the case of a partial
  recovery from a file system corruption event. Unless something really bad has
  happened to our system, this directory will remain empty.
- `/media` - on modern Linux systems the `/media` directory will contain the
  mount points for removable media such as USB drives, CD-ROMs, etc. that are
  mounted automatically at insertion.
- `/mnt` - on older Linux systems, the `/mnt` directory contains mount points
  for removable devices that have been mounted manually.
- `/opt` is used to install “optional” software. This is mainly used to hold
  commercial software products that might be installed on the system.
- `/proc` is special. It is a virtual file system maintained by the Linux
  kernel. The "files" it contains are peepholes into the kernel itself. The
  files are readable and will give us a picture of how the kernel sees the
  computer.
- `/root` is the home directory for the root account.
- `/sbin` contains “system” binaries. These are programs that
  perform vital system tasks that are generally reserved for the superuser.
- `/tmp` is intended for the storage of temporary, transient files created by
  various programs. Some configurations cause this directory to be emptied each
  time the system is rebooted.
- `/usr` contains all the programs and support files used by regular users.
- `/usr/bin` contains the executable programs installed by the Linux
  distribution. 
- `/usr/lib` - the shared libraries for the programs in `/usr/bin`.
- `/usr/local` is where programs that are not included with the distribution
  but are intended for systemwide use are installed. Programs compiled from
  source code are normally installed in `/usr/local/bin`. On a newly installed
  Linux system, this tree exists, but it will be empty until somebody puts
  something in it.
- `/usr/sbin` contains more system administration programs.
- `/usr/share` contains all the shared data used by programs in `/usr/bin`.
  This includes things such as default configuration files, icons, screen
  backgrounds, sound files, etc.
- `/usr/share/doc` - most packages installed on the system will include some
  kind of documentation. In `/usr/share/doc`, we will find documentation files
  organized by package.
- `/var` - with the exception of `/tmp` and `/home`, the directories we have
  looked at so far remain relatively static, that is, their contents don't
  change. The `/var` directory tree is where data that is likely to change is
  stored. Various databases, spool files, user mail, etc. are located here.
- `/var/log` contains log files, records of various system activity. These are
  important and should be monitored from time to time. The most useful ones are
  `/var/log/messages` and `/var/log/syslog`. Note that for security reasons on
  some systems only the superuser may view log files.

## Symbolic Links

You are likely to see a directory listing (for example, `/lib`) with an entry
like this:

> lrwxrwxrwx 1 root root 11 2007-08-11 07:34 libc.so.6 -> libc-2.6.so

Notice how the first letter of the listing is `l` and the entry seems to have
two filenames? This is a special kind of a file called a **symbolic link** (also
known as a **soft link** or **symlink**). In most Unix-like systems it is
possible to have a file referenced by multiple names. While the value of this
might not be obvious, it is really a useful feature.

## Hard links
There is a second type of link called a hard link. Hard links also allow files
to have multiple names, but they do it in a different way. We’ll talk more
about the differences between symbolic and hard links in the next chapter.
