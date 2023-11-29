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


