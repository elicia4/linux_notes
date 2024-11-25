# `sha256sum`

[***Table of Contents***](/README.md)

It's used to compute the SHA-256 checksum of a file or stream:

```bash
sha512sum file.txt
```

As of 2023, SHA-256 is the most commonly used member of the SHA-2 family of
hash functions and is still considered to be cryptographically secure.

The SHA-256 algorithm is widely used by many applications, such as: 
- the bitcoin consesus algorithm
- TLS certificates
- password hashing mechanisms

It works by splitting the input message into 512-bit blocks consisting of 16
32-bit values. 

The hashing progress is initialized using 8 constants that consist of the first
thirty-two bits of the fractional parts of the square roots of the first eight
prime numbers. Then 64 rounds of logical operations are performed to produce
the final 256-bit hash output.

All of the SHA family checksum commands support the same flags and features,
such as reading from STDIN or verifying checksums in a file:

```bash
echo "Hello World!" | sha512sum
sha512sum -c sha512-checksums.txt
```
