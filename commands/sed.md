# The "sed" stream editor

Notes taken on this video by LearnLinuxTV: https://youtu.be/nXLnx8ncZyE

[***go back to README***](/README.md)  

`sed` can be used to filter and modify text. It's often used with text files to
change things inside text files, but it can also be used for many other
purposes.

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

This will output the text from `toppings.txt`, but "Pineapple" will be
substituted with "Feta". The file itself **did not** get modified, all it did
is return the contents of the file with the changes done to it. So what did the
command do? `sed` used `toppings.txt` as an input file, and then it executed
the find-and-replace command (`'s/Pineapple/Feta/'`) against the contents of
the file. 

To change the file, use the `-i` option, it allows us to change things in
place:

```
sed -i 's/Pineapple/Feta/' toppings.txt
```

This time, there's no output. The output was sent to the file itself.

Now let's try changing 'Feta' to something else:

```
sed 's/Feta/Olives/' toppings.txt
```

This will replace all occurences of 'Feta' to 'Olives'. 

Now let's talk about the `/` delimiter. When it comes to `sed`, the character
that follows `s` is the delimiter, you can change every occurance of `/` to a
different character, let's say a space:

```
sed 's Feta Olives ' toppings.txt
```

You can change it to `|`, or `.`, or any other symbol:

```
sed 's|Feta|Olives|' toppings.txt
sed 's.Feta.Olives.' toppings.txt
sed 's)Feta)Olives)' toppings.txt
```

Every tutorial online uses `/` as the delimiter, nothing wrong with that until
there is. For instance, what if a character that you want to replace IS a `/`.
You can escape characters of course, but it's a lot easier to just use a
different delimiter. 

Let's take a look at an example. Output the contents of your `/etc` directory
to a file like so:

```
find /etc -type f > paths.txt
cat paths.txt
```

As you can see, every line starts with `/etc/` let's say you want to get rid of
that. It's easy to do by using a delimiter other than `/`, since the `/` symbol
is part of the name itself. Let's use a `.` as a delimiter:

```
sed 's./etc/..' paths.txt
```

The default way (which does not work) would be:

```
sed 's//etc///' paths.txt
```

Note that you can replace anything with nothing by putting literally nothing
between two delimiters: `'s/something//'`.

Try this thing out :)

```
echo "hello" | sed 's/hello/goodbye/'
```

There is a lot more to `sed`, these are just the very basics :)
