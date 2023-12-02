# The `lsof` command

Notes taken on the "Linux Crash Course - The `lsof` Command" video by
Learn Linux TV.

[***Table of Contents***](/README.md)

`lsof` helps to find out which files are opened on your system and by whom or
what. `lsof` stands for "list open files". 

There are situations when this may be useful, for example error messages that
say that you can't delete a file because it's in use. Another example is a 
security issue.

The basic usage of `lsof` is:

    lsof

It gives a lot of output, pipe it into `head`:

    lsof | head

Make the font size smaller to see everything clearly. Every line pertains to an
open file. 
- The first column is `COMMAND`, that's the command that's associated with that
  open file. 
- The next is `PID`, that pertains to the process that has that file open.
- `TID` is "thread identifier"
- `TASKCMD` is "task command". Generally this will be the same as the process
  named in the COMMAND  column, but some task implementations (e.g., Linux)
  permit a task to change its command name.
- `USER` lets you know which user created the process. Use `grep` to narrow the
  output down
- `TYPE` contains what kind of object the item happens to be: a directory, a
  file and so on.
- `NODE` refers to the inode number of the file, every file has an inode and
  that number differentiates one file from another
- `NAME` is the name of the object

The command doesn't show everything, only the things that the user has access
to. To see how many lines you have in the `lsof` output:

    lsof | wc -l

The number is likely going to be pretty big, and that doesn't include all of
them, try:

    sudo lsof | wc -l

Some of the lines are invalid, but most of them aren't. You only get access to
listings you have access to view.

Use the `USER` column to narrow down the output:

    lsof | grep username

There's a built-in option that makes this process even easier:

    lsof -u username # -u = username

You can narrow the output by process as well, to illustrate this easier install
`apache2`:

    sudo apt install apache2 

Make sure it's running (to double sure open `localhost` in your web browser):

    systemctl status apache2

To narrow it down by process:

    sudo lsof -c apache2 | wc -l # -c is the process option

To see the processes themselves:

    sudo lsof -c apache2 # -c is the process option
    
You can narrow down the output by PID:

    sudo lsof -p 12278 # -p is the process ID option

Here's a real-world example, you examine open files in a directory:

    sudo lsof /mnt/wp-content

You can use `-u` as an exception filter by using `^`, to view open files not
owned by `root`:

    sudo lsof -u ^root

You can view open files pertaining to IPv4 or IPv6 addresses:

    sudo lsof -i 4 /mnt/wp-content # -i for IP, 4 for version
