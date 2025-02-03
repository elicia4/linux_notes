# `unlink`

[***Table of Contents***](/README.md)

Delete individual files:

```bash
unlink file.txt
```

It can delete hard links, soft links, named pipes, and normal files. 

According to the GNU info pages, the GNU `unlink` cannot delete directories,
though other versions of `unlink` may be able to do so.

`unlink` can only delete one file at a time, unlike `rm`.

Info pages describe `unlink` as a minimalist tool that avoids "the bells and
whistles" of `rm`. `unlink` does not support any interesting flags, unlike the
much more complicated `rm`.

`unlink` appeared as early as 1964 in the MULTIX design notebook documents,
which was 5 years development of the UNIX OS had even started.
