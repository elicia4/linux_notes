# `b2sum`

[***Table of Contents***](/README.md)

It can be used to compute the BLAKE2 message digest of a file or stream:

```bash
b2sum data.txt
echo "Hello World\!" | b2sum
```

When you run the command, you'll see a 512-bit check sum value. It looks
similar to the one that's produced by the `sha512sum` command. However, while
`sha512sum` uses the 512-bit variant of the SHA-2 hash function, `b2sum` uses
the 512-bit variant of the BLAKE2b function.

BLAKE2 is advertised as being faster than MD5, SHA-1, SHA-2, and SHA-3 hash
functions. Yet it's at least as secure as the latest standard SHA-3.

As described in Request for Comments 7693, the BLAKE2b hash function was first
announced in 2012. It's based on a similar algorithm from 2008 that was one of
5 finalists of the Cryptographic Hash Algorithm Competition. 
