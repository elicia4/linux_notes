# `factor`

[***Table of Contents***](/README.md)

Calculate prime factors of integers:

```bash
factor 14
# 14: 2 7
```

As you can see, it prints back the number followed by the ascending list of its
prime factors.

More than one number can be specified:

```bash
factor 20 24
```

It can read numbers from STDIN:

```bash
echo -e "123\n321" > numbers.txt
cat numbers.txt | factor
# 123: 3 41
# 321: 3 107
```

Some of the prime factors appear more than once.

The program uses the Pollard's rho algorithm to find the prime factors.

Some numbers may be too large for it, but the documentation (`info factor`)
and the source code imply that it can be compiled in such a way that supports
arbitrary precision.
