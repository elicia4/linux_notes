# Navigating the Filesystem

Notes on the video "Linux Crash Course: Navigating the Linux Filesystem" by
Learn Linux TV.

[***go back to README***](/README.md)  

This video is extremely introductory, you probably know all this by now.

There are two meanings of the term "file system":
1. A system on your hard disk that defines how data is written to and
   retrieved. On Windows, popular file systems are: FAT, NTFS and so on. On
   Linux we have ext4 among others.
1. The layout of your directories on your system. We are going to discuss this.

On Linux, you don't have to have file extensions. 

What is your default current directory? It's `/home/your_username`, its
shorthand for `~`.

Everything begins in the root directory (`/`). Inside it, there's the `home`
directory, which contains all user directories, including yours.

There are many other directories inside the root directory. There's an entire
PDF which is called Linux File System Hierarchy standard which provides a
definition of typical directories and their purposes.

- The `boot` directory contains files that allow your system to boot. 
- The `etc` directory is where your system-wide configurations are, as opposed
  to the local configurations stored inside your own `home` directory, you
  should consider backing up this directory if you work on a server and want
  all your configs to be safe.
- The `media` and `mnt` directories are used for mounting external storage
  devices. `mnt` is for permanent storage, `media` is for temporary storage.
- The `opt` directory's purpose depends on context. The Filesystem Hierarchy
  Standard says this about `/opt/\*`:
  >"/opt is reserved for the installation of add-on application software
  >packages."
- ...and so on.

To create multiple embedded folders at the same time:

    mkdir -p third_folder/subdir1/subdir2 # p stand for parent

To remove a directory:

    rm -r directory # r means recursive
