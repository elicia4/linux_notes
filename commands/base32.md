# `base32`

[***Table of Contents***](/README.md)

The command is used to encode or decode from base-32 encoding:

```bash
echo "base32" | base32
echo "Hello World" | base32
```

The base-32 character set is defined in 'Request for Comments: 4648':
- 0-25 -- A-Z
- 26-31 -- 2-7
- padding -- `=`

`-d` to decode:

```bash
echo "Hello World" | base32 | base32 -d
```

`base32` is useful for reliably encoding non-printable binary characters into a
form that can't be easily corrupted by other programs:

```bash
echo -n -e '\x00\x01\x02\x95\x96\x97' | xxd
echo -n -e '\x00\x01\x02\x95\x96\x97' | base32 | base32 -d | xxd
```

`base32` is immune to information loss from capitalization changes, but
`base64` is not:

```bash
echo "Hello World" | base32 | tr 'A-Z' 'a-z' | tr 'a-z' 'A-Z' | base32 -d
echo "Hello World" | base64 | tr 'A-Z' 'a-z' | tr 'a-z' 'A-Z' | base64 -d
```

However, `base32` will use more characters than `base64` when representing the
same piece of data:

```bash
echo "Hello World" | base32
echo "Hello World" | base64
```
