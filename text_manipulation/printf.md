# `printf`

[***Table of Contents***](/README.md)

`printf` is used to print formatted strings, it's a shell builtin in `bash`. It
doesn't accept STDIN, it's rarely used on the command line, it's mostly used in
scripts. 

It can be thought of as a thin wrapper around the `printf` function from the C
standard library. 

It's capable of printing formatted strings in ways that are more advanced than
`echo`.

The format is:

```bash
printf "format" arguments
```

The first argument is the format string to print. Percentage signs (%) indicate
the location where arguments will be substituted. It's followed by zero or more
arguments:

```bash
printf 'First: %c Second: %d Third: %s.\n' 'p' 123 "Hello"
```

The `"format"` string contains the string itself as well as a format
description, which is then applied to a list of `arguments`. The result is then
sent to STDOUT. The example contains literal text, an escape sequence and
*conversion specifications* (sequences beginning with `%`). The `%s` string
specifier was substituted for the `Hello` string. There are other types of data
specifiers:
- `d` - a number as a signed decimal integer.
- `f` - a floating-point number.
- `o` - an integer as an octal number.
- `s` - a string.
- `x` - an integer as a hexadecimal number using lowercase `a` to `f`
  where needed.
- `X` - same as x but use uppercase letters.
- `%` - print a literal % symbol (i.e., specify %%)

E.g.:

```bash
printf "%d, %f, %o, %s, %x, %X, %%\n" 380 380 380 380 380 380 
```

It supports floating-point numbers with flags that control the format and
precision:

```bash
printf "Floating-point number: '%.2f'.\n" 420.69
printf "Floating-point number: '%.10f'.\n" 420.69
```

It also supports signed or unsigned integers, characters, strings and many
more:

```bash
printf "%u\n" -1
printf "%i\n" -1
printf "0x%X\n" 3735928559
printf "Octal characters: '%b' '%b' '%b'.\n" "\0141" "\0142" "\0143"
```

`printf` can be implemented separately as a Shell builtin or independently as a
standalone application:

```bash
type -a printf
```

Therefore its behavior could depend on the version you use.

Here's how you can customize the conversion specifiers:

```bash
%[flags][width][.precision]conversion_specification
```

- `flags`, there are five different flags:
   - `#` : Use the "alternate format" for output. This varies by data type.
     For `o` (octal number) conversion, the output is prefixed with 0. 
     For `x` and `X` (hexadecimal number) conversions, the output is 
     prefixed with "0x" or "0X" respectively.
   - `0` (zero): Pad the output with zeros. This means that the field will 
     be filled with leading zeros, as in 000380.
   - `-` (dash): Left-align the output. By default, `printf` right-aligns 
     output.
   - ` ` (space): Produce a leading space for positive numbers.
   - `+` (plus sign): Sign positive numbers. By default, `printf` only 
     signs negative numbers. 
- `width`, a number specifying the minimum field width.
- `.precision`, for floating-point numbers, specify the number of digits of
  precision to be output after the decimal point. For string conversion,
  precision specifies the number of characters to output.

`printf` is mostly used in scripts to format tabular data, rather than on the
command line directly:

```bash
printf "Line: %05d %15.3f Result: %+15d\n" 1071 3.14156295 32589 
```

Or:

```bash
printf "<html>\n\t<head>\n\t\t<title>%s</title>\n\t</head>\
\n\t<body>\n\t\t<p>%s</p>\n\t</body>\n</html>\n" "Page Title" "Page Content"
```
