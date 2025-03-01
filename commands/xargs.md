# `xargs`

[***Table of Contents***](/README.md)

Allows you to pass items from STDIN as arguments to another command.

```bash
echo "apple banana orange" | xargs echo
seq 5 | xargs echo # = `seq -s ' ' 5`
```

Many commands allow you to take STDIN and use it as a parameter (`grep`, `sed`,
`awk` etc.). Many don't, such as `ls`, `rm` etc., `xargs` is particularly
useful for these ones.

If you don't use an explicit command with `xargs`, it defaults to `echo`:

```bash
seq 5 | xargs
```

`-t` prints the resulting command on STDERR and then executes it:

```bash
seq 5 | xargs -t
```

E.g, to get info on every directory in the current directory:

```bash
find -maxdepth 1 -type d | xargs ls -ld
```

To get a list of users on your system sorted alphabetically on one line:

```bash
cut -d: -f1 < /etc/passwd | sort | xargs
```

`-I` allows you to specify a placeholder to signify the output of a command:

```bash
ls | xargs -I {} echo "${HOME}/{}"
```

E.g., you can create a thousand `.txt` files like so (the better way is `touch
{0001..1000}.txt`, but this is just an example):

```bash
seq -w 1000 | xargs -I {} touch {}.txt
```

`-w` - equalize width by padding with leading zeroes.

To change the extension of these files from `.txt` to `.text`:

```bash
ls | cut -d. -f1 | xargs -I {} mv {}.txt {}.text
```

To specify most arguments per command line (`xargs`'s command will use 2
arguments per command):

```bash
ls | xargs -t -n 1
ls | xargs -t -n 2
```

This is especially useful for commands that only accept one argument (i.e., you
want to use each argument separately):

```bash
echo test{01..10} | xargs -n 1 useradd -m
```

`-P` to run multiple processes at the same time:

```bash
seq 5 | xargs -n 1 -P 1 bash -c 'echo $0; sleep 1;'
seq 5 | xargs -n 1 -P 4 bash -c 'echo $0; sleep 1;'
```

`find` is often used with `xargs`. You can't pipe anything into `find`, but you
can use the output of it with `xargs`:

```bash
# remove all .text files from the current directory
time find . -type f -name "*.text" -exec rm {} \;
# or just use xargs, it should be faster
time find . -type f -name "*.text" | xargs rm
```

So the conclusion is: if you're worried about speed in your scripts, use
`xargs` instead of `find`'s `-exec`.
