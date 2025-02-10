# `sum`

[***Table of Contents***](/README.md)

Compute the 16-bit checksum of a file or stream:

```bash
sum file
```

It's one of the older checksum commands dating back to the first version of
UNIX from 1971.

If you run `sum` with only file arguments or with `-r`, you'll see the 16-bit
checksum for each file. The checksum is followed by a number that indicated how
many 1KB data blocks the checksum algorithm encountered. It corresponds to the
BSD checksum algorithm:

```bash
sum file file2 file3
sum -r file file2 file3
```

If you run it with `-s`, you'll see different checksum values, followed by the
number of 512-bit blocks:

```bash
sum -s file file2 file3
```

This output corresponds to the SYSV checksum algorithm. Both of these
algorithms are completely useless from the security perspective and their
continued existence is only for the legacy use cases.

You can check out the algorithms in the source code:
[https://git.savannah.gnu.org/cgit/coreutils.git/tree/src/sum.c](https://git.savannah.gnu.org/cgit/coreutils.git/tree/src/sum.c)
