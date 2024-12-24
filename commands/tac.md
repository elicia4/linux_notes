# `tac`

[***Table of Contents***](/README.md)

It's used to print files in reverse order:

```bash
cat file
tac file
```

By default, it works just like `cat` except it prints the lines in a file in
reverse order.

With `-s` you can also specify a custom separator and the order of the items
between the separators will be reversed:

```bash
echo -n "one-two-three-" | tac -s '-'
```

`info tac` states that you can use the following regular expression-based
separator to reverse the order of all bytes in a file:

```bash
tac -r -s 'x\|[^x]'
```

^ This isn't entirely true:

```bash
echo -en "\x00\x01" | tac -r -s 'x\|[^x]' | xxd # correct
echo -en "\x80\x81" | tac -r -s 'x\|[^x]' | xxd # incorrect
```
