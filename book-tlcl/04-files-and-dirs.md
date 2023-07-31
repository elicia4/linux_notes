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
