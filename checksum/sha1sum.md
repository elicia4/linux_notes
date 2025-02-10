# `sha1sum`

[***Table of Contents***](/README.md)

`sha1sum` is used to compute the SHA1 checksum of a file/stream. It's
cryptographically insecure, avoid using it. It can come in handy when you need
to verify older checksums.

```bash
sha1sum file.txt
echo "Hello World" | sha1sum
```

It also supports the `-c` flag for validating lists of checksums in files:

```bash
sha1sum -c sha1-checksums.txt
```

The SHA-1 algorithm is a cryptographic hash function that was developed by the
NSA and publish in 1995. It divides the input message into 512-bit blocks and
uses 80 rounds of logical operations on each block to calculate the 160-bit
hash output. As of 2023, it's no longer considered cryptographically secure.
However, SHA-1 is still used by `git`. References to the SHA-1 fingerprints can
still be found in TLS certificates.
