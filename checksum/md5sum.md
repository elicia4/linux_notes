# `md5sum`

[***Table of Contents***](/README.md)

It's used to calculate the MD5 checksum of file(s):

```bash
md5sum file1 ...
```

You can use the `-c` flag to specify a file that contains a list of file names
and checksums. Each filename listed in the file will be compared against the
expected checksum. If the checksum fails to match, a message stating so will be
displayed. E.g.:

```bash
NEW_FILE=$(mktemp -p .) # create a temp file in the current dir
echo "123" > $NEW_FILE # add some data to it
md5sum $NEW_FILE | tee checksum.txt # save its checksum
md5sum -c checksum.txt # see if the check succeeds
echo "321" >> $NEW_FILE # add new data to the file, it's different now
md5sum -c checksum.txt # see if the check succeeds
rm $NEW_FILE checksum.txt # remove the files
```

Note that the algorithm is not cryptographically secure. But the function is
still widely used for non-cryptographic purposes.
