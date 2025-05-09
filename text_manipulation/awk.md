# `awk`

Notes taken on [this video](https://youtu.be/oPEnvuj9QrI) by LearnLinuxTV.

[***Table of Contents***](/README.md)  

`awk` is more of a scripting language than a command. You can use it to
manipulate text and do all kinds of things. 

You can use `awk` to create filters that accept input, change it in some way
and then send that changed data to the standard output. You can also chain
commands into `awk`.

Create a sample text file:

```bash
echo "leonardo blue leader\nraphael red hothead\nmichelangelo orange \
party-animal\ndonatello purple geek" > tmnt.txt
```

In the file `tmnt.txt` you have information on each ninja turtle.

`awk` sees spaces as delimiters for fields, so in your file you have three
fields in each line: name, bandana color, and personality trait.

The general structure of `awk`:

```bash
awk '<command>' <file-name>
```

E.g.:

```bash
awk '{print}' tmnt.txt
```

This will have the same output as `cat tmnt.txt`. Now let's try to show a
specific field:

```bash
awk '{print $1}' tmnt.txt
```

This will output the first field only from each line. You can output the second
column by using `$2` instead of `$1` and so on. Here we are printing individual
fields. We added the `print` command within the brackets, technically that's a
script inside the brackets. If you change the field number to '0' (`$0`), the
entire file will be printed to the SO. You can output multiple fields like so:

```bash
awk '{print $1,$3}' tmnt.txt
```

Again, you don't have to use `awk` with a file, you can chain commands into
`awk`:

```bash
ls -l | awk '{print $5,$9}'
```

Let's take a look at another example of the `awk` command:

```bash
awk '{print $NF}' tmnt.txt
```

`$NF` stands for "number of fields". Whatever the last field happens to be, is
what's going to be printed.

There are cases where the fields are not separated by spaces but with some
other symbol, for instance the `/etc/passwd` file has its fields separated by
columns (`:`). The `-F` option allows us to set a different delimiter:

```bash
awk -F':' '{print $1,$7}' /etc/passwd
```

You should get a list of names and shell paths.

These are the basics of `awk`. :)
