# `head` & `tail`

These are notes on [the "Linux Crash Course - The `head` and `tail` Commands"
video by LearnLinuxTV.](https://www.youtube.com/watch?v=5EqL6Fc7NNw) and other
sources.

[***Table of Contents***](/README.md)

`head` shows the first 10 lines of a file, `tail` shows the last 10:
    
```bash
head /var/log/syslog; tail /var/log/syslog;
```

You should probably copy the `syslog` file first:

```bash
cp /var/log/syslog .
```

To see how many lines you have in your `syslog` file:

```bash
cat /var/log/syslog | wc -l
```

To show a specific number of lines use `-n`:

```bash
head -n 25 syslog; tail -n 25 syslog;
```

Let's view the first 10 lines containing `ssh` in `syslog`:

```bash
cat syslog | grep ssh | head
```

`-f` allows you to follow a file in real time:
    
```bash
tail -f /var/log/syslog
```

Execute a command in another terminal window to see changes happening in the
`syslog` file, for example:

```bash
sudo systemctl restart ssh
```

It's updating in near-real time, it's not perfect. 

It's also a good idea to check the authorization log file sometimes
(`auth.log`):

```bash
tail -f /var/log/auth.log
```

Use `-n 0` with `-f` if you're only interested in new lines (= don't care about
old ones at all):

```bash
tail -f -n 0 /var/log/auth.log
```

To easily differentiate, add some line breaks (press `Enter` a couple of times)
in the `tail`ing window so that you can clearly see the new output when it
appears.

`tail -f` is essential for troubleshooting, memorize it.

### More on `tail`

Again, `tail` prints the tail end of a file/stream. It works great with other
commands. Say you have a list of names in a file 'names.txt'. To print out the
5 least used names:

```bash
cat names.txt | sort | uniq -c | sort -nr | tail -n 5
```

`-c` can be used to specify the number of bytes (instead of lines) you want to
output:

```bash
tail -c 30 file.txt
```

`-c` and `-n` consider negative and unqualified numbers as counting from the
end of a file:

```bash
# the same thing
tail -c 10 file.txt
tail -c -10 file.txt
# NOT the same thing
tail -c +10 file.txt # will print out all lines starting from the 10th
```

`+<number>` is used to print the tail end of a file from the line <number>
until the end of a file. Note that the lines in this context are numbered from
1, not from 0. So `tail -n +1` will output the entire file.

### More on `head`

`head` is used to output the head of a file/stream.

Here's an interesting example. Say you have a large unknown file and decide to
print out the binary contents of the file. If you don't want to see a gigantic
output you can easily get lost in and just want to see the first few lines of
the output, use `head`:

```bash
xxd file.txt | heaad
```

`-c` to print out the first few bytes of a file:

```bash
head -c 30 file.txt
```

With `-n -<number>`, print all but the last `<number>` lines of each file.
