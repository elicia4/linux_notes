# The `paste` command

[***Table of Contents***](/README.md)

`paste` allows you to add one or more columns of text to a file, to "write
lines consisting of the sequentially corresponding lines from each file,
separated by tabs, to standard output."

Let's say you had two files, one called 'dates.md' with the following contents:

```
11/25/2008 
10/30/2008 
06/19/2008
```

...and the other called 'versions.md' with the following contents:

```
Fedora  10 
Ubuntu  8.10 
SUSE    11.0
```

If you do:

```bash
paste dates.md versions.md > dv.md
cat dv.md
```

You get the combination of two files with their columns combined.
