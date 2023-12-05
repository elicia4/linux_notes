# The `locate` command

[***Table of Contents***](/README.md)

`locate` find files by name, it does it by searching databases prepared by
`updatedb` and outputs paths to the files:

    locate zip
    locate bin/zip

There are several variants of the `locate` command, the most common ones are
`slocate` and `mlocate`. Recently created files might not be shown by `locate`.
To fix that, run:

    updatedb

That command provides databases needed for `locate`.
