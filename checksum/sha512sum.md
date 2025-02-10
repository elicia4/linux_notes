# `sha512sum`

[***Table of Contents***](/README.md)

It's used to compute the SHA-512 checksum of a file or stream:

```bash
sha512sum file.txt
```

SHA-512 is extremely similar to SHA-256. The differences are mostly found in
the block sizes. Many of the bit shift and rotation values are also different.

SHA-512 uses the 80 calculation constants instead of the 64 that SHA-256 uses.
SHA-512 uses 80 rounds of computation instead of the 64 that SHA-256 uses. 

The initial 8 hash values of SHA-512 come from the 64 bits of the fractional
parts of the square roots of the first eight prime numbers.

All of the SHA family checksum commands support the same flags and features,
such as reading from STDIN or verifying checksums in a file:

```bash
echo "Hello World!" | sha512sum
sha512sum -c sha512-checksums.txt
```
