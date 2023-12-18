# The `printf` command

[***Table of Contents***](/README.md)

`printf` (print formatted) is used to format and print data, it's a shell
builtin in `bash`. It doesn't accept STDIN, it's rarely used on the command
line, it's mostly used in scripts. It's an implementation of the C programming
language's `printf` function. The format is:
```bash
printf "format" arguments
```
For example:
```bash
printf "I formatted the string: %s\n" foo
```
The `"format"` string contains the string itself as well as a format
description, which is then applied to a list of `arguments`. The result is then
sent to STDOUT. The example contains literal text, an escape sequence and
*conversion specifications*(sequences beginning with `%`). The `%s` string
specifier was substituted for the `foo` string. There are other types of data
specifiers:
- `d` - a number as a signed decimal integer.
- `f` - a floating-point number.
- `o` - an integer as an octal number.
- `s` - a string.
- `x` - an integer as a hexadecimal number using lowercase `a` to `f`
  where needed.
- `X` - same as x but use uppercase letters.
- `%` - print a literal % symbol (i.e., specify %%)

For example:

    printf "%d, %f, %o, %s, %x, %X, %%\n" 380 380 380 380 380 380 

You can customize the conversion specifiers even further:

    %[flags][width][.precision]conversion_specification

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

    printf "Line: %05d %15.3f Result: %+15d\n" 1071 3.14156295 32589 

Or:
```
printf "<html>\n\t<head>\n\t\t<title>%s</title>\n\t</head>\
\n\t<body>\n\t\t<p>%s</p>\n\t</body>\n</html>\n" "Page Title" "Page Content"
```
