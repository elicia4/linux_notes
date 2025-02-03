# `sha224sum`

[***Table of Contents***](/README.md)

It's used to compute the SHA-224 checksum of a file or stream:

```bash
sha224sum file.txt
```

SHA-224 is one of four message digest algorithms that are part of the SHA-2
family that was created to replace the SHA-1 message digest algorithm.

The SHA-224 message digest has the smallest output size of all SHA-2 family
hash functions that are listed in the 2008 revision of the FIPS 180 standard.

According to the documentation, the specification for SHA-224 is identical to
SHA-256 except the different initial hash values are used and the final hash
value is truncated to 224 bits.

This truncation of the output bits could make SHA-224 more suitable for
applications with extremely limited storage space.

`sha224sum` supports all the same flags and features as `sha256sum`, such as
reading from STDIN or verifying checksums in a file:

```bash
echo -n "Hello World!" | sha224sum
sha224sum -c sha224-checksums.txt
```
