# The "find" file-searching tool

These are notes on [this video,](https://youtu.be/skTiK_6DdqU) man pages and 
various internet resources.

[***Table of Contents***](/README.md)  

The `find` command has many options you can use that are not included in these
notes. A simple example of the `find` command:

    find /home/admin -name *.txt 

You might want to avoid viewing hidden files. You can do it by piping commands
together, use `grep`:

    find /home/admin -name *.txt | grep -v .cache
    
Now the results that contain `.cache` will be ignored. Let's say you are only
interested in files or only in directories. Create a file named "Documents"
inside the "Documents" folder. 

To return files only, use the `-type f` option:

    find . -name Documents -type f

To return directories only, use the `-type d` option:

    find . -name Documents -type d 

Other file types supported by `find`:
- `b` - block devices
- `c` - character special device files
- `l` - symbolic links

Let's say you want to remove the "Documents" file now. To do that:

    find . -name Documents -type f -exec rm {} +
    
Now check if the "Documents" file exists. It doesn't, it's been removed!
`-exec` means that you want to execute a command against every item in the
result. In this context, `rm` is the command you want to execute. The `{}` is
the placeholder for the actual item itself. The `+` is the terminator, it's the
end of the command, it's closing each iteration off. Another variation of the 
terminator is `\;`. The `\` is used to escape the `;` character, that's an issue
with the shell.

Let's say you have a gigantic list of pictures and you want to add some
permissions to them in one shot. Of course, you can do it with the `chmod`
command itself:

    chmod -R 600 Pictures

But... It's gonna have a terrible consequence. The `600` permission is fine for
files, but it's going to mess your directory up, it will be missing the `x` bit,
thus making it unaccessible, you DO need the execute bit on it in order to get
inside that directory. You can fix it by running:

    chmod u+x Pictures

But what if you had more directories inside the "Pictures" directory? Things
get annoying pretty fast, and these annoyances can be avoided by using the
`find` command:

    find Pictures/ -type f -exec chmod 600 {} +

Now the permissions of your directories are not changed and your files are.

If you want to do something similiar to your directories:

    find Pictures/ -type d -exec chmod 700 {} +

It is actually a lot easier to use the `find` command to add file permissions.
Doing so is a good habit, especially when you're managing a file server. 

Let's say your server is full and you want to clear up some space by deleting
`.log` files. Remember that when you're on a production server, you want to make
sure that the files you're deleting are the right ones:

    sudo find /var/log -type f -name '*.log'

If you're satisfied with the output:

    sudo find /var/log -type f -name '*.log' -exec truncate -s 0 {} +

The `truncate -s 0` command will set the size of the files to exactly 0.

You can also pipe the results of `find` into a file:

    find -name '*.mp3' > results.txt

P.S. if for some reason `*` is not working, use `''` with it, so if you want to
look for all `.log` files, type `'*.log'`.

You can search by file size too:

    find ~ -type f -name "*.JPG" -size +1M
    # find all regular files in the home directory with the JPG extension and
    # the size >1MiB (mebibytes)

`+` and `-` signify greater than and less than.

Other size units are:
- `b` - 512-byte blocks
- `c` - bytes
- `w` - two-byte words
- `k` - kibibytes, KiB
- `G` - gibibytes, GiB

Some other tests `find` supports, not that `+` and `-` still work:
- `-cmin n` - file's status (contents or attributes) was last changed exactly
  `n` minutes ago.
- `cnewer file` - file's last status (contents or attributes) change is more
  recent than that of the last status change of the reference file.
- `-ctime n` - file's  status  was  last  changed exactly n\*24 hours ago.
- `-empty` - file/directory is empty
- `-group name` - file belongs to group `name`
- `-user name` - files or directories that belong to `name`, can be either a
  username or a numeric ID
- `-nouser` - files or directories that do not belong to a user
- `-nogroup` - files or directories that do not belong to a group
- `-name pattern` - files that match a pattern
- `-iname` - case-insensitive `-name`
- `-inum n` - files with inode number `n`
- `-mmin n` - file's data was last modified `n` minutes ago
- `-mtime n` - file's data was last modified n\*24 hours  ago
- `-newer file` - files and directories whose contents were modified more
  recently than the specified file.
- `-perm mode` - files and directories whose permissions are set to `mode`.
  `mode` supports both octal and symbolic notaion
- `-samefile file` - files with the same inode number as `file`, notice the
  difference between this and `inum`
- `-size n` - files of size `n`
- `-type c` - files of type `c`

`find` supports logical operators as well:

    find ~ \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)

This finds files in the home directory whose permissions are not `0600` and
directories whose permissions are not `0700`.

`find` logical operators:
- `(` and `)` - used to force precedence. Need to be quoted since `(` `)` have
  special meaning to the shell, like so: `\(`, `\)`
- `-not expr` or `\! expr` - true if expression is false
- `-and`, `-a`, `expr1 expr2` - true if both are true, `expr2` is not evaluated
  if `expr1` is false, `-and` is implied
- `-or`, `-o` - true if either one is true, second expression is not evaluated
  if the first one is true
