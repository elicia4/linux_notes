# `cut`

These are notes on [this video](https://www.youtube.com/watch?v=GYP2T34v56E),
documentation, and the Internet.

[***Table of Contents***](/README.md)

It's used to cut column out of text documents. It can be used with multiple
arguments.

It could be thought of as a primitive terminal-based version of performing a
cut operation inside of a spreadsheet program.

Imagine you have a file that contains a list of books in tab-separated column
format:

```bash
Tropic of Cancer    Henry Miller    1934
Deliverance James Dickey    1970
Slaughterhouse-Five Kurt Vonnegut   1969
```

You can use `cut -f` to extract each column individually by its one-based index
number. You can extract multiple columns at once as well:

```bash
cut -f 1 books.txt
cut -f 2 books.txt
cut -f 3 books.txt
```

Most of the use cases for `-f` are made redundant by the more powerful `awk`:

```bash
cat books.txt | awk -F'\t' '{print $1"\t"$3}'
```

It's even pointed out in the `cut` info-page:

```bash
info cut # /awk
```

`-b` can be used to extract columns based on byte offsets. Say you have a text
document that contains model numbers of products:

```bash
US-AXA-XDD-2005
RS-AHA-LOL-2001
RU-AHA-LOL-2003
```

The first two characters are the country and the last four are the year. To
extract the country code and the year together:

```bash
cut -b 1-2,12-15 file.xd
```

Popular `cut` options:
- `-c`: select by character
- `-d delim`: select by delimiter, when `-f` is specified, use `delim` as the
  field delimiting character. By default, fields must be separated by a single
  tab character
- `-f`: select by field
- `--complement` - extract the entire line of text, except for those portions
  specified by `-c` and/or `-f`

Let's try another one:

```bash
cut -b 1,2,3,4 message.txt
```

You got characters 1-4. You can also use `-`:

```bash
cut -b 1-4 message.txt
```

`b` stands for bytes, `c` stands for characters. In this example, they will
give the same output:

```bash
cut -c 1-4 message.txt
```

This works because 1 character is 1 byte, in this case, it's the same thing.
But if your characters are more than 1 byte (they are from a different
language for example), this won't work.

`cut` allows us to cut a file to whatever we select.

You don't have to commit to a range or to individual bytes, you can do both:

```bash
cut -c 1-4,6-7,9  message.txt
```

You can also separate a file by a field:

```bash
cut -f 1,2 message.txt
```

This will print the entire message because you didn't set a delimiter, that's a
special character that you can pass to the command that tells it how to
differentiate fields. Let's set the delimiter to ` `:

```bash
cut -d " " -f 1,2 message.txt
```

Now you get the first two words. 

An example of using `cut` in the real world:

```bash
cut -d ":" -f 1,7 /etc/passwd
```

The file's delimiter is `:`.

While working with `cut`, it's useful to know about the `expand` and the
`unexpend` commands. The first one converts tabs to spaces, the second converts
spaces to tabs.
