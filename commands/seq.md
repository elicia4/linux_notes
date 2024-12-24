# `seq`

[***Table of Contents***](/README.md)

It's used to print a sequence of numbers:

```bash
seq 1 6
```

```
1
2
3
4
5
6
```

When you run it with a single numerical argument, it will print all integers
from one to the specified number:

```bash
seq 5
```

```
1
2
3
4
5
```

```bash
seq 4.2
```

```
1
2
3
4
```

If you run it with two numerical arguments, the output will consist of the
first number incremented by 1, up until a value not exceeding the second
number:

```bash
seq 3 6
```

```
3
4
5
6
```

```bash
seq 3.3 6.2
```

```
3.3
4.3
5.3
```

If you provide three numerical arguments, the middle number specifies the
increment value:

```bash
seq 1 2 10
```

```
1
3
5
7
9
```

```bash
seq 1 0.1 1.5
```

```
1.0
1.1
1.2
1.3
1.4
1.5
```

By default, the numbers are separated by a newline. You can use `-s` to specify
a different delimiter:

```bash
seq -s ':' 1 10
seq -s '-' 5 20
seq -s '_' 4 14
```

```
1:2:3:4:5:6:7:8:9:10
5-6-7-8-9-10-11-12-13-14-15-16-17-18-19-20
4_5_6_7_8_9_10_11_12_13_14
```

You can also use `-w` to cause all numbers to be printed with equal width zero
padding:

```bash
seq -w 98 103
```

```
098
099
100
101
102
103
```

`-f` allows you to specify a `printf`-style format string:

```bash
seq -f 'Lowercase Hexadecimal Float: %.7a' -1 0.4 1
seq -f 'Lowercase Scientific Notation: %e' 10000 10000 100000
```

```
Lowercase Hexadecimal Float: -0x8.0000000p-3
Lowercase Hexadecimal Float: -0x9.999999ap-4
Lowercase Hexadecimal Float: -0xc.ccccccdp-6
Lowercase Hexadecimal Float: 0xc.ccccccdp-6
Lowercase Hexadecimal Float: 0x9.999999ap-4
Lowercase Hexadecimal Float: 0x8.0000000p-3
```

```
Lowercase Scientific Notation: 1.000000e+04
Lowercase Scientific Notation: 2.000000e+04
Lowercase Scientific Notation: 3.000000e+04
Lowercase Scientific Notation: 4.000000e+04
Lowercase Scientific Notation: 5.000000e+04
Lowercase Scientific Notation: 6.000000e+04
Lowercase Scientific Notation: 7.000000e+04
Lowercase Scientific Notation: 8.000000e+04
Lowercase Scientific Notation: 9.000000e+04
Lowercase Scientific Notation: 1.000000e+05
```

`seq` can suffer from floating point and integer precision errors:

```bash
seq 1 0.0000000000000000001 1.0000000000000000009
```

```
1.0000000000000000000
1.0000000000000000001
1.0000000000000000002
1.0000000000000000003
1.0000000000000000004
1.0000000000000000005
1.0000000000000000007 # gets printed twice
1.0000000000000000007 # gets printed twice
1.0000000000000000008
1.0000000000000000009
```

Note that it can also break for really big numbers as well.
