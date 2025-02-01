# `expand`

[***Table of Contents***](/README.md)

Replace tabs with spaces:

```bash
echo -e "a\tb"
echo -e "a\tb" | xxd
echo -e "a\tb" | expand
echo -e "a\tb" | expand | xxd
```

The default number of spaces to replace each tab with is 8, but you can specify
a different number:

```bash
echo -e "a\tb" | expand -t 12
echo -e "a\tb" | expand -t 12 | xxd
```

`-i` will cause only the initial tabs, that appear before any non-blank
character, to be replaced:

```bash
cat numbers
```

```
	123	123	123
```

```bash
cat number | expand -t 10 # all tabs are replaced
cat number | expand -i -t 10 # only the first one
```

Say you have a tab-separated document. Some of it's entries are much longer
than eight characters, tabs don't expand well, so therefore it's hard to read.
You can provide a list of column offsets with `-t` so that tab characters will
be expanded with as many spaces as necessary to reach the specified offset:

```bash
cat your_file.txt | expand 1,15,30,45,60
```
