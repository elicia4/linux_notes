# The `ls` command

Notes taken on the "How to Use The ls Command on the Linux Command Line" video
by Learn Linux TV.

[***Table of Contents***](/README.md)

`ls` lists directory contents. Without any arguments, it shows the files in
your current working directory. To see where you are in the file system:

```bash
pwd
```

Your home directory is the same as `~`. 

To output results in the long listing format:

```bash
ls -l
```

This gives you a lot more information.

To give information about a specific directory, provide the path to it as an
argument:

```bash
ls -l /home
```

To display information about a directory (current by default):

```bash
ls -ld
```

To output the file sizes in human-readable format:

```bash
ls -lh
```

To show hidden files:

```bash
ls -a
```

I actually like the `-A` option more, since it excludes `.` and `..` from the 
output:

```bash
ls -A
```

In file managers, press `<CTRL+h>` to show hidden files. 

You can combine all of these options together:

```bash
ls -lAh
```

The `ls` command you use on the majority of Linux distributions is actually an
alias:

```bash
alias ls
```

If an alias is named the same way as the command itself, the alias prevails.

To run `ls` with colorized output:

```bash
ls --color
```

To have trailing symbols on certain files (like `/` for directories):

```bash
ls -F
```

You can also use a trailing slash to make sure that you're copying a file
inside a directory, that you're not doing anything else. 

A `d` at the beginning of a permissions string also indicates that a file is a
directory, a `-` indicates it's a file.

To sort files by modification time, use `-t`, to reverse the order of files,
use `-r`:

```bash
ls -lhtr
```

To sort files by file size, use `-S`:

```bash
ls -lSh
```

The `/etc` directory is a good place to sort by time if anything breaks since
most of your config files are located there, you can see what config files have
changed recently.

To display the contents of a particular directory with full paths to each file
or directory *without* printing the contents of each directory:

```bash
# ls -d /path/to/dir/*
ls -d /usr/bin/* 
```

A good-looking variation of the `ls` command:

```bash
ls -lhF --time-style=long-iso --color=auto --ignore=lost+found
```

- the `--ignore` option allows you to ignore certain directories, in this case,
it's `lost+found`

To create an alias for the `ls` command:

```bash
alias ls="ls -lhF --time-style=long-iso --color=auto --ignore=lost+found"
```

Note that when you close the terminal, this alias will be lost, you have to add
it to `.bashrc`:

```bash
vim .bashrc
```

The default alias for `ls -l` is `ll`.

The default `.bashrc` file comes from `/etc/skel`. Whenever a user with a home
directory is created, the contents of `skel` directory are added to the home
directory:

```bash
ls -la /etc/skel
```

You can add files to `/etc/skel` to change the default files for new users.

Check out additional options:

```bash
man ls
```
