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
either at the beginning of the line (`^`) or at the end (`$`) of the line:

    ls /usr/bin | grep -h '^zip'
    # zip
    # zipcloak
    # zipgrep
    # ...
    ls /usr/bin | grep -h 'zip$'
    # gunzip
    # gzip
    # funzip
    # gpg-zip
    # ...
    ls /usr/bin | grep -h '^zip$'
    # zip

`^$` matches a blank line, a beginning and end with nothing in between.

Linux has built-in dictionaries, they're located in the `/usr/share/dict`
directory, they contain lists of words. You can look up crossword words with
the help of it and regular expressions. For example, say you're looking for a
word that's 10 letters long, its second, third and fourth symbols are 'ict',
and it ends with a 'y':

    grep -i '^.ict.....y$' /usr/share/dict/words

We can also match a single character from a set of characters using *bracket
expressions*. For example:

    ls /usr/bin | grep '^[bg]zip'

All metacharacters are interpreted as literals in brackets, except for the
caret (`^`), which is used to indicate negation, and the dash (`-`), which
indicated a character range. 

If the first character is a bracket expression is a `^`, the rest of the
characters in the bracket expression should *not* be present at a given
position:

    ls /usr/bin | grep '[^bg]zip'
    # gunzip
    # funzip

Note that a negated character set *still* requires a character at a given
position, that's why `zip` wasn't found.

To find a file beginning with an uppercase letter:

    ls /usr/bin | grep '^[ABCDEFGHIJKLMNOPQRSTUVWXZY]'

The easier way to do this is with a character range:

    ls /usr/bin | grep '^[A-Z]'
    # X
    # X11
    # Xorg

You can specify multiple ranges:

    ls /usr/bin | grep '^[A-Za-z0-9]'
    # X
    # X11
    # Xorg

To specify the `-` itself you have to put it first in the brackets, like so: 

    ls /usr/bin | grep '^[-AZ]'

### POSIX Pathname Expansion Nuance

Systems using ASCII used a collation order that looks like this:

    ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz

This differs from proper dictionary order, which is like this:

    aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ

For better language support, ASCII was expanded to accomodate more languages.
To support this, a concept of *locale* was introduced, it can be adjusted to
select a particular character set needed for a particular location. We can see
the language setting:

    echo $LANG

With this setting, POSIX-compliant applications will use a dictionary collation
order rather than ASCII order. That's why you may get different results while
using wildcards, it depends on distribution as well, for example:

    ls /usr/sbin/[ABCDEFGHIJKLMNOPQRSTUVWXYZ]*
    # /usr/sbin/MAKEFLOPPIES
    # /usr/sbin/NetworkManagerDispatcher 
    # /usr/sbin/NetworkManager 

    ls /usr/sbin/[A-Z]*
    # /usr/sbin/biosdecode 
    # /usr/sbin/chat 

The second `ls` used dictionary order. 

To work around this problem, POSIX includes the following character classes:

- `[:alnum:]` - the alphanumeric characters. In ASCII, equivalent to:
  `[A-Za-z0-9]`
- `[:word:]` - the same as `[:alnum:]`, with the addition of the underscore
  (`_`) character.
- `[:alpha:]` - the alphabetic characters. In ASCII, equivalent to: `[A-Za-z]`
- `[:blank:]` - includes the space and tab characters.
- `[:cntrl:]` - the ASCII control codes. Includes the ASCII characters 0
  through 31 and 127.
- `[:digit:]` - the numerals 0 through 9.
- `[:graph:]` - the visible characters. In ASCII, it includes characters 33
  through 126.
- `[:lower:]` - the lowercase letters.
- `[:punct:]` - the punctuation characters. In ASCII, equivalent to:

  ```
  [-!"#$%&'()\*+,./:;<=>?@[\\\]_`{|}~]
  ```

- `[:print:]` - the printable characters. All the characters in `[:graph:]`
  plus the space character.
- `[:space:]` - the whitespace characters including space, tab, carriage
  return, newline, vertical tab, and form feed. In ASCII, equivalent to: `[
  \t\r\n\v\f]`
- `[:upper:]` - the uppercase characters.
- `[:xdigit:]` - characters used to express hexadecimal numbers. In ASCII,
  equivalent to: `[0-9A-Fa-f]`

You can't specify partial ranges, such as `[a-m]`.

Using character classes, the search above can be expressed as:

    ls /usr/sbin/[[:upper:]]*

This is not an example of a regular expression; rather, it is the shell
performing pathname expansion.

You can revert back to the original ASCII collation order by changing the
`$LANG` environment variable, it contains the name of the language and
character set used in your locale. To revert, set it to `POSIX`:

    export LANG=POSIX

### BRE and ERE

POSIX splits regular expressions into two kinds:
1. Basic regular expressions, or BRE
1. Extended regular expressions, or ERE

What's the difference? They support different sets of metacharacters, BRE
recognizes the following: `^ $ . [ ] *`, all other character are considered
literals. 

With ERE, these metacharacters are added: `( ) { } ? + |`. Note that the `(`,
`)`, `{`, and `}` characters are treated as metacharacters in BRE if they are
escaped with a backslash, whereas with ERE, preceding any metacharacter with a
backslash causes it to be treated as a literal.

The original version of `grep` only supports BRE. `egrep` supports ERE, GNU
version of `grep` supports ERE with the `-E` option.

### What is POSIX?

It's a set of IEEE standards, IEEE 1003. It defines the *application
programming interfaces* (APIs), shell and utilities that are to be found on a
standard Unix-like system. It's short for *Portable Operating System Interface*
(with the X added to the end for extra snappiness).

### Alternation

Alternation is the facility that allows a match to occur from among a set of
expressions, it allows matches from a set of strings or other regular
expressions. It's signified by the vertical-bar character (`|`):

    echo "AAA" | grep -E 'AAA|BBB'
    # AAA
    echo "BBB" | grep -E 'AAA|BBB'
    # BBB
    echo "CCC" | grep -E 'AAA|BBB'
    # <nothing>

The regular expression `AAA|BBB` matches either AAA or BBB. To combine
alternation with other regular expressions, use `()`:

    ls /usr/bin | grep -Eh '^(bz|gz|zip)'

### Quantifiers

- `?` - match an element zero or one time, "make the preceding (the one coming
  before) element optional". Let’s say we wanted to check a phone number for
  validity and we considered a phone number to be valid if it matched either of
  these two forms, where `n` is a digit:
  ```
  (nnn) nnn-nnnn
  nnn nnn-nnnn
  ```
  This regular expression would work:
  ```
  ^\(?[0-9][0-9][0-9]\)? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$
  ```
  Try it out!
  ```
  echo "(555) 123-1234" | grep -E '^\(?[0-9][0-9][0-9]\)? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'
  echo "555 123-1234" | grep -E '^\(?[0-9][0-9][0-9]\)? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'
  ```
- `*` - match an element zero or more times, unlike the `?`, the item may occur
  any number of times. To see if a string is a sentence (combination of lower
  and uppercase letters and spaces, starting with an uppercase letter and
  ending with a dot), use the following regular expression:
  ```
  [[:upper:]][[:upper:][:lower:] ]*\.
  ```
  Try it out:
  ```
  echo "This works." | grep -E '[[:upper:]][[:upper:][:lower:] ]*\.' 
  ```
- `+` - works like `*`, but requires at least one instance of the preceding
  element to cause a match. Here is a regular expression that will match only
  the lines consisting of groups of one or more alphabetic characters separated
  by single spaces: `^([[:alpha:]]+ ?)+$`.  
  For example:
  ```
  echo "This that" | grep -E '^([[:alpha:]]+ ?)+$'
  # This that
  echo "a b c" | grep -E '^([[:alpha:]]+ ?)+$'
  # a b c
  echo "a b 9" | grep -E '^([[:alpha:]]+ ?)+$'
  # <nothing>, 9 is not alpha
  echo "abc  d" | grep -E '^([[:alpha:]]+ ?)+$'
  # <nothing>, two spaces, doesn't match the pattern
  ```
- `{n, m}` - minimum and maximum number of required matches of the preceding
  element. More specifically:
  - `{n}` - exactly `n` times (times == `n`);
  - `{n,m}` - at least `n` times but no more than `m` times (`n` <= times <=
    `m`);
  - `{n,}` - `n` or more times (times >= `n`);
  - `{,m}` - no more than `m` times (times <= `m`)
  With this, we simplify the phone number regular expression further:
  `^\(?[0-9]{3}\)? [0-9]{3}-[0-9]{4}$`

  For example:
  ```
  echo "(555) 123-4567" | grep -E '^\(?[0-9]{3}\)? [0-9]{3}-[0-9]{4}$' 
  # (555) 123-4567
  echo "555 123-4567" | grep -E '^\(?[0-9]{3}\)? [0-9]{3}-[0-9]{4}$' 
  # 555 123-4567
  echo "5555 123-4567" | grep -E '^\(?[0-9]{3}\)? [0-9]{3}-[0-9]{4}$' 
  # <nothing>
  ```
