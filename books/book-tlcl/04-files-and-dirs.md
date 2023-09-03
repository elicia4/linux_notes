# Manipulating Files and Directories

***[Contents](00-intro.md)***
---

- `cp` – Copy files and directories
- `mv` – Move/rename files and directories
- `mkdir` – Create directories
- `rm` – Remove files and directories
- `ln` – Create hard and symbolic links

Copy all the HTML files from one directory to another but *only* copy files
that do not exist in the destination directory or are newer than the versions
in the destination directory:

``` 
cp -u *.html destination 
```

Since the shell uses filenames so much, it provides special characters to help
us rapidly specify groups of filenames. These special characters are called
wildcards. Using wildcards (which is also known as *globbing*) allows us to
select filenames based on patterns of characters. 

- `*` matches any characters
- `?` matches any single character
- `[characters]` matches any character that is a member of the set characters
- `[!characters]` matches any character that is not a member of the set
characters
- `[[:class:]]` matches any character that is a member of the specified class

The most used character classes are:

- `[:alnum:]` matches any alphanumeric character
- `[:alpha:]` matches any alphabetic character
- `[:digit:]` matches any numeral 
- `[:lower:]` matches any lowercase letter
- `[:upper:]` matches any uppercase letter

Avoid using character range notations such as `[A-Z]`, `[a-z]`, `[0-9]`, and so
on. These are traditional Unix notations and worked in older versions of Linux
as well. They can still work, but you have to be careful with them because they
will not produce the expected results unless properly configured. For now, you
should avoid using them and use character classes instead. 

**TIP**: wildcards work in the GUI too.

**A note on notation**: When three periods follow an argument in the
description of a command (as above), it means that the argument can be
repeated:

``` 
mkdir dir1 dir2 dir3 
```

`cp` options:

- `-a` `--archive` - copy the files and directories and all of their
attributes, including ownerships and permissions. Normally, copies take on the
default attributes of the user performing the copy. 
- `-i` `--interactive` - before overwriting an existing file, prompt the user
for confirmation. If this option is not specified, `cp` will **silently,**
**without warning** overwrite files.
- `-r` `--recursive` recursively copy directories and their contents. This
option (or the `-a` option) is required when copying directories.
- `-u` `--update` when copying files from one directory to another, only copy
files that either don't exist or are newer than the existing corresponding
files, in the destination directory. This is useful when copying large numbers
of files as it skips files that don't need to be copied.
- `-v` `--verbose` - display informative messages as the copy is performed.

The reason why one should (or not) use the `-r` option while copying
directories:

``` 
cp dir1/* dir2 
```

Using a wildcard, copy all the files in `dir1` into `dir2`. The directory
`dir2` must already exist.

``` 
cp -r dir1 dir2
```

Copy the contents of directory `dir1` to directory `dir2`. If directory `dir2`
**does not** exist, it is created and, after the copy, will contain the same
contents as directory `dir1`. If directory `dir2` **does** exist, then
directory `dir1` (and its contents) will be copied into `dir2`.

The `mv` and `rm` commands have similiar options.

An important `rm -f` example:

- `rm -r file1 dir1` - delete `file1` and `dir1` and its contents.
- `rm -rf file1 dir1` - same as the previous command, except that if either
`file1` or `dir1` do not exist, `rm` will continue silently.

***BE CAREFUL WITH `rm`!!!***

Here is a useful tip: whenever you use wildcards with `rm` (besides carefully
checking your typing!), test the wildcard first with `ls`. This will let you
see the files that will be deleted. Then press the `up arrow key` to recall the
command and replace `ls` with `rm`.

### `ln` - create links

The `ln` command is used to create either hard or symbolic links. It is used in
one of two ways. 

The following creates a hard link:

``` 
ln file link 
```

The following creates a symbolic link:

``` 
ln -s item link 
```

`item` is either a file or a directory.

**Hard links** are the Unix way of creating links, symbolic links are more
modern. By default, every file has a single hard link that gives the file its
name. 

When we create a hard link, we create an additional directory entry for a file.
Hard links have two important limitations:

1. A hard link cannot reference a file outside its own file system. This means
a link cannot reference a file that is not on the same disk partition as the
link itself.
2. A hard link may not reference a directory.

A hard link is indistinguishable from the file itself. Unlike a symbolic link,
when we list a directory containing a hard link we will see no special
indication of the link. When a hard link is deleted, the link is removed but
the contents of the file itself continue to exist (that is, its space is not
deallocated) until all links to the file are deleted. 

**Symbolic links** were created to overcome the limitations of hard links.
Symbolic links work by creating a special type of file that contains a text
pointer to the referenced file or directory. In this regard, they operate in
much the same way as a Windows shortcut, though of course they predate the

Windows feature by many years.

A file pointed to by a symbolic link, and the symbolic link itself are largely
indistinguishable from one another. For example, if we write something to the
symbolic link, the referenced file is written to. However when we delete a
symbolic link, only the link is deleted, not the file itself. If the file is
deleted before the symbolic link, the link will continue to exist but will
point to nothing. In this case, the link is said to be broken. In many
implementations, the ls command will display broken links in a distinguishing
color, such as red, to reveal their presence.

When thinking about **hard links**, it is helpful to imagine that files are
made up of two parts.

1. The data part containing the file's contents.
2. The name part that holds the file's name.

When we create *hard links*, we are actually creating additional *name parts*
that all refer to the same *data part*. The system assigns a chain of *disk
blocks* to what is called an **inode**, which is then associated with the *name
part*. Each *hard link* therefore refers to a specific *inode* containing the
file's contents.

The `ls` command has a way to reveal this information. It is invoked with the
`-i` option.

```
total 16
12353539 drwxrwxr-x 2 me   me   4096 2023-01-14 16:17 dir1
12353540 drwxrwxr-x 2 me   me   4096 2023-01-14 16:17 dir2
12353538 -rw-r--r-- 4 me   me   1650 2023-01-10 16:33 fun
12353538 -rw-r--r-- 4 me   me   1650 2023-01-10 16:33 fun-hard
```

**Symbolic links** were created to overcome the two disadvantages of hard
links.

1. *Hard links* cannot span physical devices.
2. *Hard links* cannot reference directories, only files.

**Symbolic links** are a special type of file that contains a text pointer to
the target file or directory.

Remember, when we create a *symbolic link*, we are creating a text description
of where the target file is **relative** to the symbolic link.

In most cases, using relative (compared to absolute) pathnames is more
desirable because it allows a directory tree containing symbolic links and
their referenced files to be renamed and/or moved without breaking the links.

In addition to regular files, symbolic links can also reference directories.
