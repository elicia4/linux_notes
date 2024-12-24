# `sha384sum`

[***Table of Contents***](/README.md)

It's used to compute the SHA-384 checksum of a file or stream:

```bash
sha384sum file.txt
```

SHA-384 is nearly identical to SHA-512. The major difference is that the output
of SHA-384 is truncated from 512 bits to 384 bits. This is similar to how
SHA-224 is a truncated version of the SHA-256 version, but uses different
initial hash values. 

SHA-384 also uses different initial hash values, which consist of the first 64
bits of the fractional parts of the square of the ninth through sixteenth prime
numbers.

One advantage of using SHA-384 is that it has many of the same cryptographic
properties of SHA-512, but the resulting hash values require substantially less
storage space.

All of the SHA family checksum commands support the same flags and features,
such as reading from STDIN or verifying checksums in a file:

```bash
echo "Hello World!" | sha384sum
sha384sum -c sha384-checksums.txt
```
