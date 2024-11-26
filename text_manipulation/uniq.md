# `uniq`

[***Table of Contents***](/README.md)

It can be used to find a unique set of lines in a file. `uniq` will only give
correct results when the input lines have been presorted, use `sort` to achieve
that.

Say you had a file `list.txt` with duplicate lines, to remove the
duplicates:

```bash
sort list.txt | uniq    
```

To only see the duplicates, use `-d`:

```bash
sort list.txt | uniq -d
```

`-u` to output only unique lines:

```bash
sort list.txt | uniq -u
```

`-c` to show a count for the number of occurrences of each line:

```bash
sort list.txt | uniq -c
```

Because of capitalization differences, the command might not work as a user
intends it to. Use `-i` to ignore case:

```bash
sort list.txt list2.txt list_capitalized.txt | uniq -i
```

`uniq` options:
- `-d` - output only repeated lines
- `-f n` - ignore `n` leading fields in each line. Fields are separated by
  whitespace as they are in `sort`; however, unlike `sort`, `uniq` has no
  option for setting an alternate field separator
- `-s n` - skip the leading `n` characters of each line
