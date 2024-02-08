# Scripting Introduction

A shell script is a file containing a series of commands. To create a script:
1. Write it
1. Make it executable
1. Place it somewhere the shell can find it

Create a simple script:

```bash
vim hello_world
```

```bash
#!/bin/bash

# This is your first script.

echo 'Hello World!'
```

`# This is your first script.` is a comment, they are ignored by the
interpreter.

The `#!` is a special character sequence called a shebang. It tells the kernel
the name of the interpreter that should be used to execute the script.

Make the script executable:

```bash
ls -l hello_world
chmod 755 hello_world
ls -l hello_world
```

`755` is for scripts that anyone can execute and `700` is for personal scripts.

You can now run it:

```bash
./hello_world
```

### Script Locations

To run it normally, the script should be stored in one of the directories
listed in `$PATH`:

```bash
echo $PATH
```

Move it to your home's `bin` folder:

```bash
mv hello_world ~/bin
```

If `$PATH` doesn't contain the directory, add the following line to your
`.bashrc`:

```bash
export PATH=~/bin:"$PATH"
```

You can `source` the `.bashrc` like so:

```bash
. .bashrc
```

On Ubuntu, if you create a `bin` directory in your home folder, it will be
added to `$PATH` automatically after you relog.

The `~/bin` folder is only good for scripts intended for personal use. If you
want your scripts to be used by anybody, the best place to put them is
`/usr/local/bin`. Scripts intended for use by sysadmins should be stored in
`/usr/local/sbin` 

Locally supplied software, whether scripts or compiled programs, should be
placed in the `/usr/local` hierarchy and not in `/bin` or `/usr/bin`. These
directories are specified by the Linux Filesystem Hierarchy Standard to contain
only files supplied and maintained by the Linux distributor.

### General Scripting Advice

1. Use long options with scripts. It makes them easier to maintain and
   understand:
   ```bash
   ls -ad
   ls --all --directory
   ```
1. Split long commands over multiple lines with `\` and indentation. This is
   bad:
   ```bash
   find playground \( -type f -not -perm 0600 -exec chmod 0600 ‘{}’ ‘;’ \) -or
   \( -type d -not -perm 0700 -exec chmod 0700 ‘{}’ ‘;’ \) 
   ```
   This is good:
   ```bash
   find playground \
   \( \
       -type f \
       -not -perm 0600 \
       -exec chmod 0600 ‘{}’ ‘;’ \
   \) \
   -or \
   \( \
       -type d \
       -not -perm 0700 \
       -exec chmod 0700 ‘{}’ ‘;’ \
   \)

   ```
1. Configure `vim` for script writing. Turn on syntax highlighting: 
   ```
   :syntax on
   ```
   Or:
   ```
   :set syntax=sh
   ```
   Highlight search results:
   ```
   :set hlsearch
   ```
   Specify the number of columns occupied by the tab character:
   ```
   :set tabstop=4
   ```
   Turn on autoindent:
   ```
   :set autoindent
   ```
   To stop it, press `<CTRL-d>`.

   Add these settings to `.vimrc` to make them permanent.
