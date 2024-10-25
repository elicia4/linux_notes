# `ln`

[***Table of Contents***](/README.md)

`ln` can be used to create links between files and directories. These
links can act like shortcuts.

To create a symbolic link that links to the destination file:

```bash
ln -s destination_file.txt link_file
```

Now you can access the file via the original file and the symbolic link. To
view where a symbolic link points:

```bash
ls -l
```

You can create a symbolic link to files in other directories. 

See more info on links in [the "Symbolic Links" note](../misc/sym_links.md).
