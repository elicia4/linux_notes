# `comm`

[***Table of Contents***](/README.md)

It's used to find all of the lines that are common between two files:

```bash
cat A.txt
# a
# b
# c
cat B.txt
# b
# c
# d
comm -12 A.txt B.txt
# b
# c
```

It can also be used to compute other set operations:

```bash
# only set A
comm -2 A B
# only set B
comm -1 A B
# intersection
comm -12 A B
# substract B from A
comm -23 A B
# substract A from B
comm -13 A B
# union
comm A B
# disjunctive union
comm -3 A B
# empty set
comm -123 A B
```

Each number that's supplied to `comm` corresponds to an area in the Venn
diagram *that will be suppressed from the final output*:
- `1` - items only contained in A (no intersections)
- `2` - items only contained in B (no intersections)
- `3` - intersection

By default, `comm` will tab-indent the lines based on the column number that
they belong to.

You can remove the indentation by specifying the empty custom output delimiter:

```bash
comm --output-delimiter='' <(sort A) <(sort B)
```

`comm` expects both inputs to be sorted. If they're not, the output may be
incorrect.
