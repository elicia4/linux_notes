# `csplit`

[***Table of Contents***](/README.md)

Split up text files based on certain context:

```bash
cat example.txt
```
```
1
2
SEPARATOR
3
4
```
```bash
csplit example.txt '/SEPARATOR/'
```
```bash
ls
```
```
example.txt xx00 xx01
```
```bash
cat xx00
```
```
1
2
```
```bash
cat xx01
```
```
SEPARATOR
3
4
```

Say you have a list of weekdays with some data below each one of them. To
separate the file into sections for each weekday:

```bash
csplit file.txt '/.*day--/' {*}
```

-`'/.*day--/'` matches the header for each day of the week (Mon**day**,
Tues**day**, etc.)
- `{*}` tells `csplit` to try and match the regular expression pattern as many
times as possible.

You can use `-f` to change the prefix of the resulting split files:

```bash
csplit -f 'day-' file.txt '/.*day--/' {*}
```

You can specify the number of pattern matches that will result in file splits:

```bash
csplit -f 'day-' file.txt '/.*day--/' {3}
```

You can split files based on line number instead of a regex pattern:

```bash
csplit -k -f 'part-' file.txt '4' {*}
```

`csplit` uses basic regular expressions.
