# The `join` command

[***Table of Contents***](/README.md)

The `join` command is used to join lines of *two* files based on a common
field.

Say you had two files, 'dates-distros.txt' with these contents:

```
11/25/2008  Fedora 
10/30/2008  Ubuntu 
06/19/2008  SUSE 
05/13/2008  Fedora 
04/24/2008  Ubuntu 
11/08/2007  Fedora
```

And 'dates-versions.txt' with these:

```
11/25/2008  10 
10/30/2008  8.10 
06/19/2008  11.0 
05/13/2008  9 
04/24/2008  8.04 
11/08/2007  8
```

To join these files based on the same field:

    join dates-distros.txt dates-versions.txt

By default, `join` uses whitespace as the input field delimeter and a single
space as the output field delimeter. To specify a tab delimeter for both
input and output, use `-t $'\t'`.
