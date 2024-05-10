# Strings and Numbers

[***Table of Contents***](./00-contents.md)

Shell provides features that manipulate strings and numbers.

### Parameter Expansion

*NOTE: enclose parameter expansions in double quotes to prevent word
splitting, unless that behaviour is needed.*

To use a variable, you typically just use `$var`. But what if you wanted to use
the variable as a part of a larger string? `echo $var_txt` wouldn't work, the
shell would look for `$var_txt`, find nothing and output nothing. To fix that,
use the `${var}` notation:

```bash
var=123
echo "$var_txt"
echo "${var}_txt"
```

#### Working with Empty Variables

Several expansions are intended to deal with nonexistant/empty variables. These
are useful to assign default values and handle missing arguments.

`${parameter:-word}` *expands* to the value to `word` if `parameter` is
unset/empty. If it isn't, it results in `parameter`.

`${parameter:=word}` *expands* and to the value to `word` and gets assigned the
value of `word` if `parameter` is unset/empty. If it isn't, it results in
`parameter`.

**Note: Positional and other special parameters cannot be assigned this way.**

`${parameter:?word}` causes the script to exit with an error and `word` is
printed to STDERR if `parameter` is unset/empty. If not, expands to the value
of `parameter`.

`${parameter:+word}` expands to nothing if `parameter` is unset. If it's set,
the value of `word` is substituted for `parameter`. The value remains
unchanged.

#### Expansions that Return Var Names

`${!prefix*}`, `${!prefix@}` expands to variable names that start with
`prefix`.

#### String Operations

`${#parameter}` expands into the length of the string contained by `parameter`.
If `parameter` is `@`/`*`, the expansions results in the number of postional
arguments.

`${parameter:offset}`, `${parameter:offset:length}` are used to extract string
portions contained in `parameter`. It begins at `offset` until the end of the
string unless `length` is specified. If `offset` is negative, it starts from
the end of the string. Negative values should be preceded by ` ` to avoid
confusion with `${var:-}`. `length` can't be 0. If `parameter` is `@`, the
result of the expansion is `length` positional parameters, starting at
`offset`.

`${parameter#pattern}`, `${parameter##pattern}` remove a leading portion of the
string contained in `parameter` defined by `pattern.` `pattern` is a wildcard
pattern like those used in pathname expansion. The difference in the two forms
is that the `#` form removes the shortest match, while the `##` form removes
the longest match:

```bash
foo=file.txt.zip
echo ${foo#*.}
# txt.zip
echo ${foo##*.}
# zip
```

`${parameter%pattern}`, `${parameter%%pattern}` are the same, but they remove
text from the end:

```bash
foo=file.txt.zip
echo ${foo%.*}
# file.txt
echo ${foo%%.*}
# file
```

`${parameter/pattern/string}`, `${parameter//pattern/string}`,
`${parameter/#pattern/string}`, `${parameter/%pattern/string}`

Performs a search-and-replace operation upon `parameter`. If text is found
matching wildcard `pattern`, it is replaced with `string`. In the normal form,
only the first occurrence of `pattern` is replaced. In the `//` form, all
occurrences are replaced. `/#` changes the first match, and `/%` the last.
In every form, if `/string` is omitted, the text matched by `pattern` is
deleted.

```bash
foo=JPG.JPG
echo ${foo/JPG/jpg}
# jpg.JPG
echo ${foo//JPG/jpg}
# jpg.jpg
echo ${foo/#JPG/jpg}
# jpg.JPG
echo ${foo/%JPG/jpg}
# JPG.jpg
```

#### Case Conversion

The `declare` command can be used to normalize strings to either uppercase or
lowercase, we can force a variable to always contain the desired format:

```bash
#!/bin/bash
# ul-declare: demonstrate case conversion via declare
declare -u upper
declare -l lower

if [[ $1 ]]; then
    upper="$1"
    lower="$1"
    echo "$upper"
    echo "$lower"
fi
```
```bash
ul-declare aBc
# ABC
# abc
```

There are 4 parameter expansions that do the same:

- `${parameter,,pattern}` - convert `parameter` into all lowercase.
`pattern` is an optional shell pattern (for example, [A-F]) that will limit
which characters are converted. 
- `${parameter^^pattern}` - convert `parameter` into all uppercase letters.
- `${parameter,pattern}` - convert `parameter`, changing only the first
character to lowercase.
- `${parameter^pattern}` - convert `parameter`, changing only the first
character to uppercase.

```bash
#!/bin/bash
# ul-param: demonstrate case conversion via parameter expansion
if [[ "$1" ]]; then
    echo "${1,,}"
    echo "${1^^}"
    echo "${1,}"
    echo "${1^}"
fi
```
```bash
ul-param aBc
# abc
# ABC
# aBc
# ABc
```

### Arithmetic Evaluation and Expansion

Its basic form is as follows:

```bash
$((expression))
```

#### Number Bases

The shell supports integer constants in any base:

- `number` - by default, numbers without any notation are treated as decimal
(base 10) integers.
- `0number` - in arithmetic expressions, numbers with a leading zero are
considered octal.
- `0xnumber` - hexadecimal notation.
- `base#number` - number is in base

```bash
echo $((0xff))
# 255
echo $((2#11111111))
# 255
```

#### Unary Operators

`+` and `-` indicate if a number is positive or negative.

#### Arithmetic Operators

- `+` - addition
- `-` - subtraction
- `*` - multiplication
- `/` - integer division
- `**` - exponentiation
- `%` - modulo (remainder)

#### Assignment

In addition to the `=` notation, there are other:

- `parameter = value` - simple assignment
- `parameter += value` - addition. Equivalent to `parameter=parameter + value`
- `parameter -= value` - subtraction
- `parameter *= value` - multiplication
- `parameter /= value` - integer division
- `parameter %= value` - modulo
- `parameter++` - post-increment
- `parameter−−` - post-decrement
- `++parameter` - pre-increment
- `--parameter` - pre-decrement

#### Bit Operations

These operators work at the bit level. They are used for certain kinds of
low-level tasks, often involving setting or reading bit-flags:

- `~` - bitwise negation. Negate all the bits in a number.
- `<<` - left bitwise shift. Shift all the bits in a number to the left.
- `>>` - right bitwise shift. Shift all the bits in a number to the right.
- `&` - bitwise AND. Perform an AND operation on all the bits in two numbers.
- `|` - bitwise OR. Perform an OR operation on all the bits in two numbers.
- `^` - bitwise XOR. Perform an exclusive OR operation on all the bits in two
numbers.

`$((op1<<op2))`:
- `op1` is the value whose bits are to be shifted
- `op2` is the number of positions by which the bits are to be shifted

There are also corresponding assignment operators (for example, `<<=`) for all
but `~`.

#### Logic

`(( ))` supports a variety of comparison operators:

- `<=` - less than or equal to.
- `>=` - greater than or equal to.
- `<` - less than.
- `>` - greater than.
- `==` - equal to.
- `!=` - not equal to.
- `&&` - logical AND.
- `||` - logical OR.
- `expr1?expr2:expr3` - comparison (ternary) operator. If expression `expr1`
evaluates to be non-zero (arithmetic true), then `expr2`; else `expr3`.

When used for logical operations, expressions follow the rules of arithmetic
logic; that is, expressions that evaluate as zero are considered false, while
non-zero expressions are considered true.

An example of ternary operator:

```bash
a=0
((a<1?++a:--a))
echo $a
# 1
((a<1?++a:--a))
echo $a
# 0
```

To do assignment withing a ternary operator:

```bash
((a<1?(a+=1):(a-=1)))
```

### `bc`

You can't do non-integer math directly with the shell. One way to do it is with
a specialized calculator program `bc`. The `bc` program reads a file and
executes it. It may be a separate file, or it may be read from STDIN. It
supports variables, loops, and functions. Refer to the man-page for a detailed
description of `bc`.

`bc` uses the same syntax as C for comments. Multi-line comments: `/* text */`.

```c
/* 2 + 2 */
2 + 2
```

To run it:

```bash
bc prog.bc
```

To suppress the copyright message:

```bash
bc -q prog.bc
```

It can also be used interactively:

```bash
bc -q
```

The `quit` command quits.

You can pass scripts to `bc` via STDIN:

```bash
bc < prog.bc
```

That means that you can use here documents, here strings, and pipes to pass
scripts:

```bash
bc <<< "2+2"
# 4
```
