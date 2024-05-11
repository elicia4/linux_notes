# `for`

[***Table of Contents***](./00-contents.md)

The `for` loop provides a means of processing sequences during a loop. It has
two forms.

### `for` Shell Form

```bash
for variable [in words]; do
    commands
done
```

- `variable` is the variable that will increment during the loop
- `words` is an optional list of items that will be sequentially assigned to
the variable
- `commands` are the commands to be executed on each iteration

E.g.:

```bash
$ for i in {A..D}; do echo $i; done
A
B
C
D
```

Especially useful with pathname expansions. To delete all `.txt` files in the
current directory:

```bash
$ for i in *.txt; do rm "$i"; done
```

If the optional `in words` portion is omitted, for defaults to processing the
positional parameters.

### `for` C Form

```bash
for (( expression1; expression2; expression3 )); do
    commands
done
```

`expression1`, `expression2`, and `expression3` are arithmetic expressions and
`commands` are performed during each iteration.

In term of behaviour, this form is equivalent to:

```bash
(( expression1 ))
while (( expression2 )); do
    commands
    (( expression3 ))
done
```

E.g.:

```bash
#!/bin/bash 
# simple_counter: demo of C style for command 

for (( i=0; i<5; i=i+1 )); do 
    echo $i 
done
```
```bash
0
1
2
3
4
```

`expression1` initializes the variable `i` with the value of 0, `expression2`
allows the loop to continue as long as the value of `i` remains less than 5,
and `expression3` increments the value of `i` by 1 each time the loop repeats.

[***Next Note***](./11-strings_nums.md)
