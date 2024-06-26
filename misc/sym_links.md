# Symbolic Links

Notes on the video "Linux Crash Course - Symbolic Links" by LearnLinuxTV.

[***Table of Contents***](/README.md)  

Linking is a way to link one object to another.

We know that a file is a directory because of its permission string, the first
symbol is `d`:

```bash
ls -l
```

`-` means that it's a regular file.

`-i` means "inodes":

```bash
ls -i
```

An inode is a data object that contains metadata about the files within your
file system, they contain every piece of information regarding the files:

- Size
- Owner
- Permission string
- Last modified date
- Type (directory, regular file, etc.)
- ...and so on

Inodes are represented by an integer.

Every storage medium has its own set of inodes, an inode is a one-to-one match
to a file. Every directory has an inode.

A link is useful since it allows to access objects that are located elsewhere
from a different place. Links give you quick access to things.

Create a random file inside `Documents`:

```bash
touch ~/Documents/random_file.txt
```

Create a symbolic link for the file on your Desktop:

```bash
ln -s /home/user/Documents/random_file.txt /home/user/Desktop/link_itself
```

Use full paths for links. See if it exists:

```bash
ls -l ~/Desktop
```

At the beginning of the permission string, you see `l`, meaning link. You can
manipulate the link file with whatever commands you want, the original file
will be edited:

```bash
vim ~/Desktop/link_itself
```

So how do inodes relate to symbolic links? They do not have the same inode
number:

```bash
ls -li ~/Desktop/ ~/Documents/
```

They are completely different objects, they both have their own inode numbers.
Symbolic links are referred to as soft links, there is another type of link
called a hard link. To create a hard link:

```bash
ln /home/user/Documents/random_file.txt /home/user/Desktop/hard_link;
ls -li ~/Desktop/ ~/Documents/
```

The hard link and the original file have the same inode number. The hard link
has `-` in its permission string, which means that it's a regular file. The
fact that they have the same inode number means that they are the *same* file.
The hard link is a duplicate entry in the file system, you can't move to a USB
and have the same file there. 

If a file you create a link for doesn't exist, the link will be invalid, it's
not going to do anything. Make sure to use absolute paths, you won't go wrong
with that.

The advantage of a symbolic link is that you can move it to another storage
medium. Also, symlinks explicitly indicate that they are links, it is useful
for collaborating with others.

Don't create symbolic links too often, it can get confusing for others. Just 
don't go crazy with it and you'll be fine.
