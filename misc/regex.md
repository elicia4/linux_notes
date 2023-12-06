# Regular Expressions

[***Table of Contents***](/README.md)

Regular expressions are symbolic notations used to identify patterns in text.
Not all regular expressions are the same, they differ from tool to tool.

[`grep` supports regular expressions.](../commands/grep.md)

Regular expressions may include *metacharacters* that are used to specify more
complex matches: `^ $ . [ ] { } - ? * + ( ) | \`.

All other characters are considered literals. To use metacharacters themselves
as literals, escape them with `\`, like so: `\$`. When you pass regular
expressions containing metacharacters, *always* enclose them in quotes to
prevent them from being expanded by the shell.

`.` is the any character, it's used to match any character. For example:

    ls /usr/bin | grep -h '.zip'

With this command, you look for all strings containing a **4-letter** string
starting with *any* character and ending with `zip`.

`^` and `$` are *anchors*. They cause matches to occur only if they are found
either at the beginning (`^`) or the end (`$`) of the line.
