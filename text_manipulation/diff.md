# `diff`

These are notes on [this video](https://www.youtube.com/watch?v=qLRQspQxvFk),
documentation, and the Internet.

[***Table of Contents***](/README.md)

It's the command you can use to find the difference between files. It supports
many output formats and can process large collections of text files at once.
`diff` can be used to create *"diff files"* that are used to convert one
version of a file to another. For practice, create two slightly different text
files:

```bash
echo "I like\ndogs and cats" > 1.txt;
echo "I like\ncats and dogs" > 2.txt;
cp 1.txt 3.txt;
cat 1.txt 2.txt 3.txt;
```

To show the difference:

```bash
diff 1.txt 3.txt
```

If there's no output at all, there's no difference, in this case, the exit code
should be 0. To show the exit code:

```bash
echo $? # if the command was successful, the code should be 0
```

To make the output a bit more verbose:

```bash
diff -s 1.txt 3.txt
```

You can look at the changes between the backup config files and current config
files:

```bash
diff /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
```

### `diff` Output

In the default output format, each group of changes is preceded by a *change
command* in the form of *range operation range* to describe the positions and
types of changes required to convert the first file to the second file.

A range is a comma-separated list of the starting and the ending lines.

An example of an output:

```
15c15  
< Port 2222
---
> #Port 22
```

- `<` relates to the the first file, `>` to the second;
- `15c15`
    - The first number refers to the line number of the first file
    - `c` stands for "changing"
    - The seconds number refers to the line number of the second file

There are some additional options not shown in the output example above.
- `d` stands for deletion, a line was removed
- `a` stands for adding, a line was added

You can colorize the output of `diff` with the `colordiff` package, install it
if you don't have it, it makes the output more clear. It's a wrapper around the
`diff` command, it doesn't change the command itself, it just colorizes the 
output:

```bash
colordiff 1.txt 2.txt
```

There is the `-u` option that formats the `diff` output in the *unified
format*, it's clearer to read:

```bash
diff -u 1.txt 2.txt
```

Or even better:

```bash
colordiff -u 1.txt 2.txt | less
```

Another type of format is the *context format*, specified with `-c`:

```bash
diff -c 1.txt 2.txt
```

`***` signifies the first file, `---` signifies the second.

Within a change group, lines begin with change indicators:
- `blank` - a line shown for context. It does not indicate a difference between
  the two files.
- `-` - a line deleted. This line will appear in the first file but not in the
  second file.
- `+` - a line added. This line will appear in the second file but not in the
  first file.
- `!` - a line changed. The two versions of the line will be displayed, each in
  its respective section of the change group.

To see how to create `diff` files and apply patches, see [`patch`](./patch.md).
