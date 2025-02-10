# `cksum`

[***Table of Contents***](/README.md)

Compute a cyclic redundancy check (CRC) checksum of a file or stream:

```bash
cksum file
```

The purpose of the command is for detecting data corruption, which can occur
during network communication or due to failing storage media. 

If you run it on a file, you'll see the CRC checksum followed by the number of
bytes in the file. E.g.:

```
2685705463 3423 linux.md
```

The checksum is not cryptographically secure and should only be used for
detecting *accidental* rather than *deliberate* data corruption.
