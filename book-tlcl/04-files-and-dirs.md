# Manipulating Files and Directories

- `cp` – Copy files and directories
- `mv` – Move/rename files and directories
- `mkdir` – Create directories
- `rm` – Remove files and directories
- `ln` – Create hard and symbolic links

Copy all the HTML files from one directory to another but *only* copy files that
do not exist in the destination directory or are newer than the versions in the
destination directory:

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
description of a command (as above), it means that the argument can be repeated:

```
mkdir dir1 dir2 dir3
```

`cp` options:

- `-a` `--archive` - copy the files and directories and all of their attributes,
  including ownerships and permissions. Normally, copies take on the default
  attributes of the user performing the copy. 
- `-i` `--interactive` - before overwriting an existing file, prompt the user
  for confirmation. If this option is not specified, `cp` will **silently,**
  **without warning** overwrite files.
- `-r` `--recursive` recursively copy directories and their contents. This
  option (or the `-a` option) is required when copying directories.
- `-u` `--update` when copying files from one directory to another, only copy
  files that either don't exist or are newer than the existing corresponding
  files, in the destination directory. This is useful when copying large
  numbers of files as it skips files that don't need to be copied.
- `-v` `--verbose` - display informative messages as the copy is performed.

The reason why one should (or not) use the `-r` option while copying
directories:

``` cp dir1/* dir2 ```

Using a wildcard, copy all the files in `dir1` into `dir2`. The directory
`dir2` must already exist.

``` cp -r dir1 dir2```

Copy the contents of directory `dir1` to directory `dir2`. If directory `dir2`
**does not** exist, it is created and, after the copy, will contain the same
contents as directory `dir1`. If directory `dir2` **does** exist, then directory
`dir1` (and its contents) will be copied into `dir2`.

The `mv` and `rm` commands have similiar options.

An important `rm -f` example:

- `rm -r file1 dir1` - delete `file1` and `dir1` and its contents.
- `rm -rf file1 dir1` - same as the previous command, except that if either
`file1` or `dir1` do not exist, `rm` will continue silently.

***BE CAREFUL WITH `rm`!!!***

Here is a useful tip: whenever you use wildcards with `rm` (besides carefully
checking your typing!), test the wildcard first with `ls`. This will let you see
the files that will be deleted. Then press the `up arrow key` to recall the
command and replace `ls` with `rm`.

