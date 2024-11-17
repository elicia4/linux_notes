# `base64`

[***Table of Contents***](/README.md)

Used to encode or decode from base-64 encoding:

```bash
echo "Hello World\!" | base64
echo "Hello World\!" | base64 | base64 -d
```

`-d` to decode. 

The character set is defined in "Request for Comments: 4648":
- 0-25 -- A-Z
- 26-51 -- a-z
- 52-61 -- 0-9
- 62 -- `+`
- 63 -- `/`
- padding -- `=`

As you can see, it uses all uppercase and lowercase letters of the alphabet, as
well as the digits 0-9, as well as `+` and `/`.

`base64` is useful for reliably encoding non-printable binary characters into a
form that can't be easily corrupted by other programs:

```bash
echo -n -e '\x00\x01\x02\x95\x96\x97' | xxd
echo -n -e '\x00\x01\x02\x95\x96\x97' | base64 | base64 -d | xxd
```

`base64` is more efficient in representing information than `base32`:

```bash
echo "Hello World" | base32 | wc -c 
echo "Hello World" | base64 | wc -c 
```

However, it's larger character set means that there are more ways for `base64`
encoded data to become corrupted in transit:

```bash
echo "Hello World" | base32 | tr 'A-Z' 'a-z' | tr 'a-z' 'A-Z' | base32 -d
echo "Hello World" | base64 | tr 'A-Z' 'a-z' | tr 'a-z' 'A-Z' | base64 -d
```
