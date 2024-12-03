# `od`

[***Table of Contents***](/README.md)

Used to produce an octal dump of a binary file:

```bash
od file.dat
```

It can also be used to produce a hexadecimal dump of a file:

```bash
od -v -A x -t x2z --endian=big data.dat
```

`xxd` and `hexdump` can produce hexadecimal dumps as well:

```bash
xxd data.dat
hexdump -C data.dat
```

Imagine you have a bitmap image file:

```bash
od image.bmp
```

It outputs lines that start with a byte offset ('0000000', '0000020', etc.)
followed by the file data. Both are presented in *octal notation*. You can make
the output more readable:

```bash
od -A x -t x2z --endian=big image.bmp
```

- `-A x` formats the addresses in hexadecimal
- `-t x2` formats the file data as 2-byte hexadecimal values
- `z` enables literal character output
- `--endian=big` swaps the byte order

By default, repeated lines are represented as an asterisk (`*`). This can be
disabled with `-v`:

```bash
od -A x -t x2z -v --endian=big image.bmp
```

`od` can extract parts of a file as integers, floating points, or characters:
- `a` - named character
- `c` - printable single byte character
- `d` - signed decimal
- `f` - floating point
- `o` - octal
- `u` - unsigned decimal
- `x` - hexadecimal

`od` can be incredibly useful for scripts, e.g., to print out fields in the
bitmap file's header.

Unlike `xxd` or `hexdump`, `od` is included in the POSIX specification.
