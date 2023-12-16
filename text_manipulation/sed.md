# The `sed` stream editor

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

`p` means "print". `-n` suppresses automatic printing.

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

### The `s` command

Let's say you had a file with dates in the `MM/DD/YYYY` format:

    echo "01/13/2001
    05/05/1999
    08/05/2005
    08/05/1984
    08/05/1325" > file.txt

To sort them easily, it would be better if they were in the `YYYY-MM-DD`
format:
```
sed 's \([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\)$ \3-\1-\2 ' file.txt 
```
Let's deconstruct it:
1. A `sed` replace command has the following structure: `sed
   's/regexp/replacement/' file.txt`
1. A regular expression (`regexp`) that isolates the `MM/DD/YYYY` dates:
   `[0-9]{2}/[0-9]{2}/[0-9]{4}$`
1. For `replacement`, we have to use *back references*, a regular expression
   feature that's supported in some applications that use BRE. It works like
   so: if `\n` appears in `replacement` where `n` is a number from
   1 to 9, `\n` will refer to the corresponding *subexpression* in the
   preceding regular expression. To create subexpressions, enclose relevant
   parts of text in parentheses: `([0-9]{2})/([0-9]{2})/([0-9]{4})$`. You now
   have three subexpressions. You can now construct a *replacement* as follows:
   ```
   \3-\1-\2
   ```

   Now the command looks like so:
   ```
   sed 's/([0-9]{2})/([0-9]{2})/([0-9]{4})$/\3-\1-\2/' file.txt
   ```
1. The extra slashes confuse `sed`. `sed` uses BRE, several of the characters
   in your regular expression are taken as literals, rather than
   metacharacters. Use backslashes (`\`) to solve both of these problems:
   ```
   sed 's/\([0-9]\{2\}\)/\([0-9]\{2\}\)/\([0-9]\{4\}\)$/\3-\1-\2/' file.txt
   ```
   Use a different delimiter to make a bit easier to understand:
   ```
   sed 's \([0-9]\{2\}\)/\([0-9]\{2\}\)/\([0-9]\{4\}\)$ \3-\1-\2 ' file.txt
   ```

You can use flags with `s`. The `g` flag allows you to perform a replacement on
the entire line, rather than just the first instance:

    echo "aaabbbccc" | sed 's/b/B/' 
    echo "aaabbbccc" | sed 's/b/B/g'

### `sed` script

Create a basic `sed` script:

    echo "# sed script to convert dates from one format to another

    1 i\\
    \\
    Formatted Dates\\

    s/\([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\)$/\3-\1-\2/ 
    y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/" > script.sed

The script contains a title and the modified dates. It also performs
transliteration of lowercase characters to uppercase characters. To run the
script, use the `-f` option:

    sed -f script.sed file.txt

How did it work? Run:

    cat -n script.sed

Line 1 is a commend, starts with a `#`. Lines 2 and 6 are blanks and can be
used to improve readability. 

Lines 3, 4, 5, and 6 contain text to be inserted at the line address 1, the
first line of the input. Line addresses are used to specify which lines of the
input are to be acted upon. They may be expressed as single line numbers, line
number ranges, and the special line number `$`, which indicates the last line
of input. 

The `i` command is followed by a backslash and then a carriage return to
produce an *escaped carriage return*, or what is called a *line-continuation
character*. This sequence allows a carriage return to be embedded in a stream
of text without signaling the interpreter (`sed`) that the end of the line has
been reached. The `i`, the `a` and `c` commands allow multiple lines of text as
long as each line, except the last, ends with a line-continuation character.
Line 6 is actually the end of our inserted text and ends with a plain carriage
return rather than a line-continuation character, signaling the end of the `i`
command. A line-continuation character is created by a `\` followed
immediately by a carriage return. No intermediary spaces are permitted.

Line 7 is our search-and-replace command. Since it is not preceded by an
address, each line in the input stream is subject to its action. 

Line 8 performs transliteration of the lowercase letters into uppercase
letters. Unlike `tr`, the `y` command in `sed` does not support character
ranges (`[a-z]`), nor does it support POSIX character classes. Again, since the
`y` command is not preceded by an address, it applies to every line in the
input stream.

Note that for hard tasks it's usually better to use other than `sed`, like
`awk` and `perl`.
