# Understanding File & Directory Permissions

These are notes on [this video](https://www.youtube.com/watch?v=4e669hSjaX8)
and more...

[***go back to README***](/README.md)  

---

To see file permissions:

    ls -l

The first section of the output is the permission string. The string is broken
down into 4 groups:

1. The first character: `d` stands for directory, `-` stands for file, `l` is
   link, `c` is a character special file (handles data as a stream of bytes,
   such as a terminal or `/dev/null`), `b` is a block special file (handles
   data in blocks, such as a hard drive or DVD);
1. The next three characters: user owner permissions, `r` is read, `w` is
   write, `x` is execute;
1. The next three characters: owner group permissions;
1. The next three characters: all other users' permissions (world).

- `r` for files means read the file, view its contents; in terms of
  directories, it means that you can see what's inside.
- `w` for files means you can modify the contents of a file; in terms of
  directories, it means you can create, delete and rename files inside the
  directory.
- `x` for files means that you can execute those files, for example scripts; in
  terms of directories, it means that you can go inside that directory.

To change a file's permissions use `chmod`. To make a file executable for all
users:

    chmod +x filename.txt

You can specify `u` for user, `g` for group, `o` for world, and `a` for all
(=`ugo`):

    chmod u+x filename.txt

You can remove permissions with `-`:

    chmod u-x filename.txt

You can set specify a combination of permissions (all others are removed by
default):

    chmod u=w filename.txt
    # this will set the 'w' bit to 1 and 'r' and 'x' bits to 0 in the user bits

You can combine options too:

    chmod go-rwx file
    # remove `rwx` permissoins from the group and the world 

You can combine permissions with commas:

    chmod u=rw,g=r,o=r file

There's a numberical representation for read, write and execute.  
Read is 4, write is 2, execute is 1, so to add permissions you sum them, for
instance `rwx` is 7, `r--` is 4, `r-x` is 5 and so on. To set a file's
permissions string to `-rwxrw-rw-`, you would use:

    chmod 766 filename.txt

You can change permissions of all files in a directory, let's say `Downloads`:

    chmod -R 600 Downloads 

This is problematic, it will execute the command on the directory itself as
well as the files inside.

To do it only on the files:

    chmod 600 Downloads/*

This will cause problems as well if you have directories inside the folder. You
won't be able to go inside those directories with these permissions. Use the
`find` command to solve this issue.

To change ownership of a directory to someone else, for example **batman**:

    chown -R batman Downloads

To change group ownership as well as user ownership:

    chown -R batman:batman Downloads
    
If both the user and the group have the same name you can shorten the command:

    chown -R batman: Downloads

To print user and group information for a user (current by default):

    id [username]...

Let's take a look at the `umask` command. It controls the default permissions
given to a file when it's created. After you set the value of umask, a binary
reset will be performed on the default maximum permissions value of a file or a
directory (for files it's `666`, for directories it's `777`). For example:

    ```
    umask 0002
    touch file
    ls -l file
    # -rw-rw-r-- 1 user user 0 Nov 26 10:40 file
    ```

How exactly was the permissions string calculated? Binary reset was performed,
everywhere a 1 appears in the binary value of the mask, an attribute is unset:

    ```
    ---rw-rw-rw- max file permissions value;
    0  6  6  6   in decimal;
    000110110110 in binary;
    0  0  0  2   mask permissions value in decimal, without the first digit
    000000000010 in binary;
    So we have: 
    000110110110
    000000000010
           ^ this bit gets reset, getting us:
    000110110100
    0  6  6  4
    ---rw-rw-r-- and this is exactly what we got
    ```

To check the current value of `umask`:

    umask

Two most common default values of `umask` are 0002 and 0022.

The first 3 bits of the *12-bit* permissions string are *setuid*, *setgid*, and
*sticky* bits. When setuid is applied (4\*\*\*) to an executable file, it sets
the effective user ID from that of the real user (the user actually running the
program) to that of the program's owner. This allows the program to access
files and directories that a user would normally be prohibited from accessing.

The setgid bit (2\*\*\*) changes the effective group ID from the real group ID
of the real user to that of the file owner. If the setgid bit is set on a
directory, newly created files in the directory will be given the group
ownership of the directory rather the group ownership of the file's creator.
This is useful in a shared directory when members of a common group need access
to all the files in the directory, regardless of the file owner's primary
group.

The third is called the  sticky bit (1\*\*\*). On files, Linux ignores the
sticky bit, but if applied to a directory, it prevents users from deleting or
renaming files unless the user is either the owner of the directory, the owner
of the file, or the superuser. This is often used to control access to a shared
directory, such as /tmp. 

To assign setuid to a program:

    chmod u+s program

To assign setgid to a directory:

    chmod g+s dir

To assign a sticky bit to a directory:

    chmod +t dir

The permissions string will change as well:
- -rw**s**r-xr-x - a program with the setuid bit set
- drwxrw**s**r-x - a directory with the setgid bit set
- drwxrwxrw**t** - a directory with the sticky bit set
