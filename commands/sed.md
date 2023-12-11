# The "sed" stream editor

These are notes on [this video](https://youtu.be/nXLnx8ncZyE), documentation,
and the Internet.

[***Table of Contents***](/README.md)  

`sed` is short for "stream editor", it is used to filter and transform (modify)
streams of text (files or standard input). `sed` can be used both on the
command line with a single command and with a script file with multiple
commands.

Create a new `toppings.txt` text file:

```
echo "Pizza topping combos:
1. Spinach, Pepperoni, Pineapple
2. Pepperoni, Pineapple, Mushrooms
3. Bacon, Banana Peppers, Pineapple
4. Cheese, Pineapple" > toppings.txt
```

Let's see what the `sed` command can do for us:

```
sed 's/Pineapple/Feta/' toppings.txt
```

All instances of "Pineapple" got substituted with "Feta" and the resulting text
was printed to the standard output, the file itself **did not** get modified.
`sed` used `toppings.txt` as an input file, and then it executed the
find-and-replace command (`'s/Pineapple/Feta/'`) against the contents of the
file. 

To change the file itself, use `-i`:

```
sed -i 's/Pineapple/Feta/' toppings.txt
```

There's no output. The output was sent to the file itself.

You can change the delimiter (`/`) to any other character:

```
sed 's Feta Olives ' toppings.txt
sed 's|Feta|Olives|' toppings.txt
sed 's.Feta.Olives.' toppings.txt
sed 's)Feta)Olives)' toppings.txt
```

Conventionally almost everywhere a `/` is used, but in cases where there are
`/` symbols in the text, it's a lot easier to use a different character instead
of escaping `/`s. For example, output the contents of your `/etc` directory
to a file:

```
find /etc -type f > paths.txt
cat paths.txt
```

Every line starts with `/etc/`, let's say you want to get rid of that. It's
easy to do by using a delimiter other than `/`, since the `/` symbol is part of
the name itself. Let's use a `.` as a delimiter:

```
sed 's./etc/..' paths.txt
```

The default way (which does not work without escaping the characters) would be:

```
sed 's//etc///' paths.txt
```

You can replace anything with nothing by putting literally nothing between the
last two delimiters:

    echo "something" | sed 's/something//'
