# `link`

[***Table of Contents***](/README.md)

Create hard links in your file system:

```bash
link target_file link_name
```

Say you have a file with some data. If you create a hard link to it, you can
interact with its contents by using either file name:


```bash
cat target_file # the output
cat link_name # is the same
```

All of the functionality of `link` is also included in `ln`. However, the
documentation claims that `link` is more portable.

Unlike `ln`, `link` does not create symbolic links.

Hard links differ from symbolic links since hard links will reference the same
file system inode, but symbolic links do not:

```bash
ls -li target_file link_name
```

As a consequence of this, `link` cannot create a link between two different
file systems, but `ln -s` can. Furthermore, hard links of the same inode share
permissions while symbolic links on Linux always have the full permissions
granted.
