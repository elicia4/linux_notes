# The GNU Core Utilities (coreutils)

The GNU Core Utilities or coreutils is a package of GNU software with many
basic tools, such as `cat`, `ls`, and `rm`, which are used on Unix-like
operating systems.

This documents is my own written version of a [video by
RobertElderSoftware](https://www.youtube.com/watch?v=2oGLlG3Whfk), it describes
the coreutils and ranks them in a tier list, based on the importance.

TO DO:
- add links to existing notes

### S tier

1. `ls` - list files.
1. `pwd` - prints the current working directory.
1. `mv` - move or rename files.
1. `cp` - copy files and directories.
1. `rm` - delete file or directories.
1. `ln` - create soft and hard links.
1. `touch` - create an empty file, modify the last modified timestamp of an
existing file.
1. `echo` - echo text onto the terminal.
1. `cat` - print one or more files to STDOUT.
1. `tail` - prints last few lines of a file.
1. `head` - print first few lines/bytes of a file.
1. `mkdir` - create directories.
1. `mktemp` - create temporary files/directories. Extremely useful for writing
scripts.
1. `realpath` - resolves a canonical absolute path of a file. It can resolve
symlinks and give you absolute paths to file if you only start with a relative
one.
1. `dirname` - strips the last component from the file path. Incredibly useful
for scripts.
1. `md5sum` - "MD5" is cryptographically insecure function, but it's still
ubiquitously found today.
1. `timeout` - run other commands with a timeout limit. If a commands runs
longer than the timeout specified, it will be terminated by `timeout`.
1. `nice` - run a program with a different priority level.
1. `chroot` - very primitive way of containerization software (???).
1. `whoami` - prints the names of the current user.
1. `hostname` -  returns the hostname of the current machine. Good for network
administration.
1. `sort` - sort lines in a file.
1. `groups` - prints a list of groups a user belongs to. Useful for debugging
permission issues.
1. `su` - become the root user. Nowadays, `sudo` is more used to become root.
I've heard `sudo` can be unsafe and `su` is more preferable.
1. `env` - print and change environment variables. A UNIX counterpart to
`printenv`.
1. `base32` - just like `base64`. Uses 32 characters instead of 64.
1. `base64` - encode binary data as ASCII text. Encountered frequently.
1. `chmod` - change permissions on files. One of the most common issue is a
permission issue, this command can help you solve it.
1. `nohup` - run another command so that it ignores the hang-up signal. Useful
for launching long-running commands you don't want to monitor.
1. `b2sum` - calculate BLAKE2 message digest of a file/stream. BLAKE2 is a
relatively new, supposedly superior hash function.
1. `chown` - change user/group ownership of a file. Can accomplish everything
`chgrp` can and more. Great for debugging permission problems.
1. `wc` - count number of lines, words, characters in a file.
1. `sha512sum` - calculate the 512-bit variant of the SHA-2 hash function.
Likely to be used more and more as the times goes on.
1. `sha256sum` - calculate the 256-bit variant of the SHA-2 hash function. One
of the most widely used has functions today.
1. `kill` - abruptly terminate a process. Can be used to send a number of
different signals to a process.
1. `dd` - copy files and block devices. Often used when working with block
   devices.
1. `sync` - flush cached rights to persistent storage. Sometimes necessary to
   prevent data loss.
1. `basename` - remove the leading path components from a file/directory path.
   Great for scripting and compliments `dirname`.
1. `tee` - redirect output to multiple files or processes. Great if you want to
   send the output to a log file and STDOUT.
1. `df` - quickest way to show the amount of disk space used.
1. `mkfifo` - create named pipes. Good for sysadmins. Complicated blocking
semantics.
1. `uniq` - count unique lines in a file. Almost always used with `sort`.
1. `date` - print out the current date with various formatting options.
1. `test` - evaluate conditional expressions. Frequently found in scripts.
1. `stdbuf` - controls the buffering behavior of STDIN/STDOUT. Great for
input/output buffering. - B/S tier
1. `sha1sum` - calculate the SHA1 checksum of a file/stream. Cryptographically
insecure, avoid using it. Still it can come in handy when you need to verify
older checksums. A must learn if you're into cryptography. - C/S tier 
1. `runcon` - run a command in a specific security context. Only relevant on
SELinux. Good for security. - D/S tier.
1. `sleep` - wait for a specified amount of time without wasting CPU cycles.
1. `mknod` - create file system nodes like block devices, e.g., `/dev/sda`.
   Great for security. It's one of the ways you can escape a `chroot`
   environment. - D/S tier

### A tier

1. `od` - produce octal/hexadecimal dumps of binary data.
1. `uptime` - prints out how long your computer has been running since it last
rebooted.
1. `true` - placeholder command you use anywhere you need a successful return
code.
1. `paste` - companion to `cut`. These programs provide you with a primitive
terminal-based spreadsheet tool.
1. `false` - returns a failure code.
1. `uname` - print various information about your system, such as: kernel
release version, version of the machine architecture, etc.
1. `fold` - fold long lines into shorter ones. Similar to `fmt`.
1. `join` - similar to SQL joins on the command line with text files. Can be
used with `cut`/`paste` commands. Requires the columns to be sorted. Can be
cumbersome.
1. `expr` - evaluate logical/mathematical/string expressions. Often used in
scripts. Evaluating complicated expressions in a shell script is usually quite
cumbersome.
1. `fmt` - more featureful version of `fold`.
1. `rmdir` - remove an empty directory. Can be used to make sure you're
deleting empty folders.
1. `comm` - compute set operations between the lines in two files. Can be very
useful, but rare. Has unfortunate caveats related to delimiters. Requires input
files to be presorted.
1. `du` - show the amount of disk space used by parts of your FS. You can use
   this command in combination with others to do things like find the 5 largest
   file on your FS.
1. `tr` - perform single character replacements on streams. One of the big use
   cases is to delete new line characters or carriage returns.
1. `printf` - print things to the terminal. Allows for advanced formatting
   options.
1. `split` - split a large files into a series of smaller ones.
1. `install` - more sophisticated version of `cp`. You can use it to copy a
   file and set its permissions at the same time. Commonly found in Makefiles.
   Often used by C/C++ programmers.
1. `shuf` - randomly reorder the lines in a file or to provide an infinite and
   random sampling of lines in a file. Good to generate test cases.
1. `tty` - prints the name of the terminal connected to STDIN. Can be used to
   determine whether your program runs on the interactive terminal or not.
1. `cut` - companion to `paste`. They provide a terminal-based spreadsheet
   tool.

### B tier

1. `users` - print list of logged in users.
1. `stty` - change many characteristics of a terminal. You can use it to
   disable character echoing. Thus character that you type won't be echoed onto
   the screen.
1. `readlink` - read symbolic links. `realpath` is preferable.
1. `id` - print the real/effective user/group ID.
1. `yes` - print out 'y' or a provided string over and over. Used to provide
'y' as confirmation to another command.
1. `sha384sum` - works like a truncated value of `sha512sum`, but with
different initialization values for the hash function. Nice to learn if you're
interested in cryptography. - D/B tier
1. `seq` - print out a sequence of numbers. Can be useful for shell scripts.
   Suffers from numerical precision errors.
1. `[` - exists to provide a syntactically consistent version of `test`.

### C tier

1. `numfmt` - format numbers that represent data size units.
1. `pathchk` - check the portability of path names.
1. `tac` - print the lines or bytes in a file in reverse order.
1. `chgrp` - change group ownership of a file/directory. The functionality of
this command is duplicated in the more powerful `chown` command.
1. `truncate` - used to truncate a file, create a large empty file, extend the
size of an existing file. Rarely used.
1. `factor` - find prime factors of numbers. Could be an interesting
benchmarking tool.
1. `logname` - similar to `whoami`. Provides the user of the currently attached
terminal, `whoami` provides the user associated with the current process. The
distinction is important, but not widely used.
1. `stat` - display information about a file or a file system. Most of the info
found in `stat` can be found with `ls`. Provides different options for
formatting the output.
1. `nproc` - tells you the number of CPU's on your system.
1. `dircolors` - configure the colors of the files that appear on your
terminal. Good for styling and customization.

### D tier

1. `who` - shows the list of users that are currently logged in. Could be
useful for multi-user systems.
1. `expand` - text utility for parsing files with tabs.
1. `hostid` - returns a canonical ID that is unique to your machine. Not used
much.
1. `cksum` - obsolete checksum algorithm.
1. `shred` - delete files, claims to securely delete data. The security
guarantees don't hold true anymore.
1. `tsort` - perform topological sorting. Originally used for sorting linker
symbols in the Unix kernel (???).
1. `unexpand` - reverse of `expand`. Doesn't quite work.
1. `printenv` - similar to `env`, but it comes from the BSD lineage. So learn
`env` instead.
1. `arch` - identical to `uname -m`. Learn `uname` instead.
1. `pr` - format text files in preparation for printing them.
1. `csplit` - used to split a text file. Cumbersome and inconvenient.
1. `ptx` - create permuted indexes, an obsolete form of documentation that was
used in some of the original versions of the Unix manual.
1. `vdir` - runs `ls` with `-lb` flags.
1. `sum` - used to calculate an obsolete Unix error check sum.
1. `unlink` - provide a backward compatible way of deleting a file. Can be
rarely useful when you want to be extra careful and only delete a file at a
time.
1. `dir` - equivalent to `ls -Cb`.
1. `sha224sum` - truncated version of `sha256sum` with different initialization
   values.
1. `link` - create a hard link. Redundant, such functionality is already
   provided by `ln`.
1. `pinky` - lightweight version of `finger`. `finger` is an obsolete command
   from the mainframe era that could be described as the first social network.
   Useless.
1. `nl` - number lines in a file. DOES NOT NUMBER BLANK LINES BY DEFAULT.
   Usually, this is undesired. There's a flag that allows such functionality.
   Supports a number of unusual flags and options. `cat -n` is preferred.
