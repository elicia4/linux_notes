# `shuf`

[***Table of Contents***](/README.md)

It can be used to generate random permutations of lines in a file:

```bash
cat key-strokes.txt
```

```
KEY_UP
KEY_DOWN
KEY_LEFT
KEY_RIGHT
```

```bash
shuf key-strokes.txt
```

```
KEY_RIGHT
KEY_LEFT
KEY_UP
KEY_DOWN
```

Use `-n` to randomly select only 2 lines from the list (or any other number of
lines):

```bash
shuf -n key-strokes.txt
```

By default, `shuf` prints each line only once. `-r` makes `shuf` repeat all
lines infinitely and randomly:

```bash
shuf -r key-strokes.txt
```

Duplicate lines can occur.

Using `head`, you can limit the output to the first 10 lines:

```bash
shuf -r key-strokes.txt | head -n 10
```

`-i` is used to specify a number range and the output will produce random
numbers filling this range:

```bash
shuf -i 1-10
shuf -i 100-120
```
