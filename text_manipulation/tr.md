# `tr`

These are notes on [this video](https://youtu.be/4qP5xA_epXo), documentation,
and the Internet.

[***Table of Contents***](/README.md)  

`tr` - replace or delete single byte characters, *transliterate* characters in
files/streams. Transliteration is the process of changing characters from one
alphabet to another.

```bash
echo "Gomer" | tr 'G' 'H'
```

`tr` is mostly used with other commands. E.g.:

```bash
echo "Hello World" | tr [a-z] [A-Z]
# The first set [a-z] is being replaced by the second set [A-Z].
# That's why all lowercase characters got replaced by UPPERCASE characters.
```

>HELLO WORLD

You can perform multiple character replacements at once:

```bash
echo "Apple_Banana" | tr 'a_' 'b='
# Apple=Bbnbnb
```

You do this by listing the search and replace character one after another.

`-c` causes the replacement to act on the complement of the character set:

```bash
cat /bin/bash | tr -c '[:print:]' '.' | less
# replaces all non-printable characters with '.' in the bash executable
```

The complement of a character set is the characters in the current locale's
character set, *except the characters specified*. So the complement of
`[:print:]` should be characters that are not printable.

Characters can be expressed in three ways. Let's take uppercase characters as
an example:
1. An enumerated list: `ABCDEFGHIJKLMNOPQRSTUVWXYZ`.
1. A character range: `A-Z`. This is subject to problems related to *the locale
   collation order* and should be used with caution.
1. POSIX character classes: `[:upper:]`.

It's possible to convert multiple characters to one:

```bash
echo "Hello World 123" | tr [:alnum:] A
```

Create a simple text file and `echo` anything you want inside it, we will do 
some work with it. I suggest doing so in a new folder so as to not mess
anything up:

```bash
mkdir new_dir && cd new_dir
echo "Anything I want inside it. I love numbers, such as 7123897123894! \
WOAW!" >> message.txt
```

There are multiple ways to input contents of a file to `tr`:

```bash
cat message.txt | tr [a-z] [A-Z] # with pipe
tr [a-z] [A-Z] < message.txt # with input redirection
```

You can delete characters with `-d`:

```bash
echo "Hello World" | tr -d [a-z]
```

>H W

E.g., to convert MS-DOS to Unix text, delete all carriage returns:

```bash
tr -d '\r' < dos_file > unix_file # \r represents the carriage return character
```

To see a complete list of sequences and characters classes `tr` supports:

```bash
tr --help
```

Create a file with a list of users:

```bash
echo -e "name@localhostt\nsam@localhostt\nliz@localhostt" > usernames.txt
cat usernames.txt
```
	
Each 'localhost' has an extra 't' at the end. You can fix it with `-s` ('s'
stands for squeeze), it's used to delete duplicate characters:

```bash
cat usernames.txt | tr -s 't'
```

Note that the characters have to be adjoining for them to squeeze.

You can rewrite `[a-z]` as `[:lower:]`, `[A-Z]` as `[:upper:]`:

```bash
cat message.txt | tr [:lower:] [:upper:]
```

You can delete all alpha characters with `[:alpha:]`:

```bash
cat message.txt | tr -d [:alpha:]
```

>    .   ,   7123897123894! !

`tr` has many caveats, such as its use of the less popular POSIX notation to
describe characters sets:

- `[:alnum:]` - all letters and digits
- `[:alpha:]` - all letters
- `[:blank:]` - all horizontal whitespace
- etc. etc. See `man tr` for more.

Its character ranges are not portable. It also lacks support for multi-byte
character replacements (!!!).

These are predefined characters classes, you can read more about them here:
https://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html
