# `expr`

[***Table of Contents***](/README.md)

It's used to evaluate expressions:

```bash
# numeric expressions
expr 1 + 2 # addition
expr 10 - 3 # substraction
expr 2 \* 4 # multiplication
expr 12 / 2 # division
expr 8 % 3 # remainder

# relational expressions
expr 1 \| 0 # logical or
expr 1 \& 0 # logical and
expr 99 \< 100 # less than
expr 99 \<= 100 # less than or equal
expr 99 \> 100 # greater than
expr 99 \>= 100 # greater than or equal
expr 100 = 100 # equal to
expr 100 != 100 # not equal to

# string expressions
expr length 'Hello World.' # length of string
expr substr 'Hello World.' 7 5 # return substring at position 'x' of length 'y'
expr index something abcdef # return the index of the first character in
                            # 'something' that is in the character set 'abcdef'
expr aaaaaa : 'a\+' # gives length of match
expr match '0xF8' '0x[0-9a-fA-F][0-9a-fA-F]' # gives length of match
expr '555-123-1234' : '[0-9]\{3\}-[0-9]\{3\}-\([0-9]\{4\}\)'
# extracts last four digits of a phone number
```

These expressions can be useful when writing shell scripts:

```bash
#!/bin/bash
if [ $(expr 123 - 100) -gt 0 ]; then 
    echo "Do something."
else
    echo "Do something else."
fi
```

It can be very easy to use this command incorrectly. Many operators need to be
escaped or quoted for shells, e.g. `>` is reserved by the shell and is used for
redirection. The correct use would be:

```bash
expr 2 \>= 1
```

A similar but even worse problem exists with multiplication expressions (`*`),
you should always escape the asterisk character:

```bash
expr 2 \* 3
```
