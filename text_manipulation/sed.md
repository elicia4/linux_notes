# The "sed" stream editor

These are notes on [this video](https://youtu.be/nXLnx8ncZyE), documentation,
and the Internet.

[***Table of Contents***](/README.md)  

`sed` is short for "stream editor", it is used to filter and transform (modify)
streams of text (files or standard input). `sed` can be used both on the
command line with a single command and with a script file with multiple
commands.

Create a new `toppings.txt` text file:

```
echo "Pizza topping combos:
1. Spinach, Pepperoni, Pineapple
2. Pepperoni, Pineapple, Mushrooms
3. Bacon, Banana Peppers, Pineapple
4. Cheese, Pineapple" > toppings.txt
```

Let's see what the `sed` command can do for us:

```
sed 's/Pineapple/Feta/' toppings.txt
```

All instances of "Pineapple" got substituted with "Feta" and the resulting text
was printed to the standard output, the file itself **did not** get modified.
`sed` used `toppings.txt` as an input file, and then it executed the
find-and-replace command (`'s/Pineapple/Feta/'`) against the contents of the
file. Commands in `sed` begin with a single letter, `s` indicates substitution.

To change the file itself, use `-i`:

```
sed -i 's/Pineapple/Feta/' toppings.txt
```

There's no output. The output was sent to the file itself.

You can change the delimiter (`/`) to any other character:

```
sed 's Feta Olives ' toppings.txt
sed 's|Feta|Olives|' toppings.txt
sed 's.Feta.Olives.' toppings.txt
sed 's)Feta)Olives)' toppings.txt
sed 's_Feta_Olives_' toppings.txt
```

Conventionally almost everywhere a `/` is used, but in cases where there are
`/` symbols in the text, it's a lot easier to use a different character instead
of escaping `/`s. For example, output the contents of your `/etc` directory
to a file:

```
find /etc -type f > paths.txt
cat paths.txt
```

Every line starts with `/etc/`, let's say you want to get rid of that. It's
easy to do by using a delimiter other than `/`, since the `/` symbol is part of
the name itself. Let's use a `.` as a delimiter:

```
sed 's./etc/..' paths.txt
```

The default way (which does not work without escaping the characters) would be:

```
sed 's//etc///' paths.txt
```

You can replace anything with nothing by putting literally nothing between the
last two delimiters:

    echo "something" | sed 's/something//'

An address to be edited can be specified. Let's say you only want specify a
line to be edited:

    echo "front" | sed '1s/front/back/' # substitution will happen
    echo "front" | sed '2s/front/back/' # substitution won't happen

`sed` Address Notation:
- `n` - a line number;
- `$` - the last line;
- `/regexp/` - lines matching a POSIX basic regular expression. The regular
  expression is delimited by slash characters, it may be delimited by an
  alternate character, by specifying the expression with `\cregexpc`, where `c`
  is the alternate character;
- `addr1,addr2` - a range of lines from `addr1` to `addr2`, inclusive. Addresses
  may be any of the single address forms listed earlier;
- `first~step` - match the line represented by the number `first`, then each
  subsequent line at step intervals. For example 1~2 refers to each odd
  numbered line;
- `addr1,+n` - match `addr1` and the following `n` lines;
- `addr!` - match all lines except `addr`, which may be any of the forms listed
  earlier.

For example:
    
    sed -n '1,5p' file.txt

`p` means "print". `-n` supresses automatic printing.

Print all lines containing `1234`:

    sed -n '/1234/p' file.txt

Print all lines that don't contain `1234`:

    sed -n '/1234/!p' file.txt

Basic `sed` editing commands:
- `=` - output the current line number;
- `a` - append text after the current line;
- `d` - delete the current line;
- `i` - insert text in front of the current line;
- `p` - print the current line, best used with the `-n` option;
- `q` - exit `sed` without processing any more lines. If the `-n` option is not
  specified, output the current line;
- `Q` - exit sed without processing any more lines;
- `s/regexp/replacement/` - substitute `regexp` with `replacement`.
  `replacement` may include the special character `&`, which is equivalent to
  the text matched by `regexp`. In addition, `replacement` may include the
  sequences `\1` through `\9`, which are the contents of the corresponding
  subexpressions in `regexp`. After the trailing slash following `replacement`,
  an optional flag may be specified to modify the `s` command's behavior;
- `y/set1/set2` - perform transliteration by converting characters from `set1`
  to the corresponding character in `set2`. Both sets must be of the same
  length.
