# Arrays

[***Table of Contents***](./00-contents.md)

Arrays are variables that hold more than one value at a time. An array has
*elements* and each element contains data. An element has an address called an
*index* or a *subscript*. Arrays in bash are one-dimensional. `sh` doesn't
support arrays.

### Creating an Array

Array variables are named just like other bash variables, and are created
automatically when they are accessed:

```bash
a[1]=foo
echo ${a[1]}
# foo
```

The use of braces in the second command is required to prevent the shell from
attempting pathname expansion on the name of the array element.

An array can also be created with the `declare` command:

```bash
declare -a a
```

The `-a` option creates an array.

### Assigning Values

Single values:

```bash
name[subscript]=value
```

`name` is the name of the array, `subscript` is an integer (`>=0`). `value` is
a string or integer assigned to the element.

Multiple values:

```bash
name=(value1 value2 ...)
```

`value` placeholders are values assigned sequentially to elements of the array:

```bash
days=(Sun Mon Tue Wed Thu Fri Sat)
```

This is also possible:

```bash
days=([0]=Sun [1]=Mon [2]=Tue [3]=Wed [4]=Thu [5]=Fri [6]=Sat)
```

### Array Operations

There are many common array operations.

#### Outputting the Contents of an Array

The subscripts `*` and `@` can be used to access every element in an array.
When quoted, the `*` notation results in a single word containing the array’s
contents, while the `@` notation results in multiple strings containing
elemenets' real contents:

```bash
animals=("a dog" "a cat" "a fish")
for i in ${animals[*]}; do echo $i; done
# a 
# dog 
# a 
# cat 
# a 
# fish
for i in ${animals[@]}; do echo $i; done
# a 
# dog 
# a 
# cat 
# a 
# fish
for i in "${animals[*]}"; do echo $i; done
# a dog a cat a fish
for i in "${animals[@]}"; do echo $i; done
# a dog 
# a cat 
# a fish
```

### Determining the Number of Array Elements

You can determine the number of elements in an array in much the same way as
finding the length of a string:

```bash
a[100]=foo
echo ${#a[@]}  # number of array elements
# 1
echo ${#a[100]}  # length of element 100
# 3
```

In bash, array elements exist only if they have been assigned a value
regardless of their subscript.

#### Finding the Subscripts Used by an Array

it is sometimes useful to determine which elements actually exist. This can be
done with a parameter expansion using the following forms:

```bash
${!array[*]}
${!array[@]}
```

Like the other expansions that use `*` and `@`, the `@` form enclosed in quotes
is the most useful, as it expands into separate words:

```bash
foo=([2]=a [4]=b [6]=c)
for i in "${foo[@]}"; do echo $i; done
# a
# b
# c
for i in "${!foo[@]}"; do echo $i; done
# 2
# 4
# 6
```

#### Adding Elements to the End of an Array

You can append values to the end of an array with `+=`:

```bash
foo=(a b c)
echo ${foo[@]}
# a b c
foo+=(d e f)
echo ${foo[@]}
# a b c d e f
```

#### Sorting an Array

There's no way to directly do it with the shell, but you can easily do it with
a script:

```bash
a=(f e d c b a) 
echo "Original array: ${a[@]}" 

a_sorted=($(for i in "${a[@]}"; do echo $i; done | sort)) # remember this
echo "Sorted array:   ${a_sorted[@]}"
```

#### Deleting an Array

To delete an array, use `unset`:

```bash
foo=(a b c d e f)
echo ${foo[@]}
# a b c d e f
unset foo
echo ${foo[@]}
# 
```

You can delete a single element with `unset` too:

```bash
foo=(a b c d e f)
echo ${foo[@]}
# a b c d e f
unset 'foo[2]'
echo ${foo[@]} 
# a b d e f
```

Note that assignment of an empty value doesn't empty an array:

```bash
foo=(a b c d e f)
foo=
echo ${foo[@]}
# b c d e f
```

Any reference to an array variable without a subscript refers to element zero
of the array:

```bash
foo=(a b c d e f)
echo ${foo[@]}
# a b c d e f
foo=A
echo ${foo[@]}
# A b c d e f
```

### Associative Arrays

Associative arrays use strings rather than integers as array indexes:

```bash
declare -A colors
colors["red"]="#ff0000"
colors["green"]="#00ff00"
colors["blue"]="#0000ff"
```

Unlike integer indexed arrays, which are created by merely referencing them,
associative arrays must be created with the `declare` command using the new
`-A` option. Associative array elements are accessed in much the same way as
integer indexed arrays. 

```bash
echo ${colors["blue"]}
```
