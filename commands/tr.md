# The `tr` command

These are notes on [this video](https://youtu.be/4qP5xA_epXo), documentation,
and the Internet.

[***Table of Contents***](/README.md)  

`tr` - translate or delete characters, *transliterate* characters.
Transliteration is the process of changing characters from one alphabet to
another.

The `tr` command is mostly used with other commands. For example:

```
echo "Hello World" | tr [a-z] [A-Z]
# The first set [a-z] is being replaced by the second set [A-Z].
# That's why all lowercase characters got replaced by UPPERCASE characters.
```

>HELLO WORLD

Characters can be expressed in three ways. Let's take uppercase characters as
an example:
1. An enumerated list: `ABCDEFGHIJKLMNOPQRSTUVWXYZ`.
1. A character range: `A-Z`. This is subject to problems related to *the locale
   collation order* and should be used with caution.
1. POSIX character classes: `[:upper:]`.

It's possible to convert multiple characters to one:

```
echo "Hello World 123" | tr [:alnum:] A
```

Create a simple text file and echo anything you want inside it, we will do 
some work with it. I suggest doing it in a new folder so as to not mess
anything up.

```
mkdir new_folder && cd new_folder
touch message.txt
echo "Anything I want inside it. I love numbers, such as 7123897123894! \
WOAW!" >> message.txt
```

There are multiple ways to input contents of a file to the tr command. The
first one is the obvious one - with pipe:

	cat message.txt | tr [a-z] [A-Z]

Another way to do it is:

	tr [a-z] [A-Z] < message.txt

You can delete characters with the `-d` option:

```
echo "Hello World" | tr -d [a-z]
```

>H W

To convert MS-DOS to Unix text, delete all carriage returns:

```
tr -d '\r' < dos_file > unix_file # \r represent the carriage return character
```

To see a complete list of sequences and characters classes `tr` supports:

```
tr --help
```

Create a file with a list of users:

```
echo -e "name@localhostt\nsam@localhostt\nliz@localhostt\njay@localhostt" > usernames.txt
cat usernames.txt
```
	
There are multiple mistakes: each localhost has an extra `t` at the end.
You can fix it with the `-s` parameter (s stands for squeeze). It is used
to delete duplicate characters. Let's delete duplicate t's:

	cat usernames.txt | tr -s 't'

Note that the characters have to be adjoining for them to squeeze.

You can rewrite `[a-z]` as `[:lower:]`, `[A-Z]` as `[:upper:]`:

	cat message.txt | tr [:lower:] [:upper:]

You can delete all alpha characters with the `[:alpha:]`:

```
cat message.txt | tr -d [:alpha:]
```

>    .   ,   7123897123894! !

Let's change `!` for `.`:

```
tr '!' '.' < message.txt
```

Check out the manpage for the `tr` command to learn more!

```
man tr
```
	
P.S.: wondering what `[:upper:]`, `[:lower:]`, `[:alpha:]` are? These
are predefined characters classes, you can read more about them here:
https://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html
