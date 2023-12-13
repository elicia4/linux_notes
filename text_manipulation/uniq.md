# The `uniq` command

[***Table of Contents***](/README.md)

Say you had a sorted list `list.txt` with duplicate lines, to remove the
duplicates:

    cat list.txt | sort | uniq    

To only see the duplicates, use `-d`:

    cat list.txt | sort | uniq -d

`uniq` options:
- `-c` - output a list of duplicate lines preceded by the number of times the
  line occurs.
- `-d` - output only repeated lines
- `-f n` - ignore `n` leading fields in each line. Fields are separated by
  whitespace as they are in `sort`; however, unlike `sort`, `uniq` has no
  option for setting an alternate field separator
- `-i` - ignore case
- `-s n` - skip the leading `n` characters of each line
- `-u` - output only unique lines
