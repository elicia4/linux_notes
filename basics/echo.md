# `echo`

Notes taken on the "Linux Crash Course - The echo Command" video by
Learn Linux TV.

[***Table of Contents***](/README.md)  

`echo` is used to print text onto the terminal:

```bash
echo "Hello, World!"
echo "Hello, 'World'!"
echo 'Hello, "World"!'
echo Hello, World!
```

You can also print out contents of variables:

```bash
msg="Hello, World";
echo $msg;
```

You can print outputs from other commands:

```bash
echo "Current date: $(date)"
```

You have quite a few variables in your session that are created for you:

```bash
env
```

Print one of them out:

```bash
echo $HOME
```

`-e` enables interpretation of escape characters (`\n` creates a new line): 

```bash
echo -e "\nHello, World!\n"
```

You can redirect the output to `sort` to sort the list of lines:

```bash
echo -e "d1\na2\nh3" | sort
```

To see a hexadecimal representation of the output:

```bash
echo -e "d1\na2\nh3" | xxd
```

You can sound an alert with `echo`:

```bash
echo -e "\aHello World"
```

This didn't work for me, but the `\a` escape is supposed to produce a sound.

There are other escapes available:

```bash
echo -e "This is a\bLinux Server"
```

You can 'abandon' text with `\c`:

```bash
echo -e "This is a\cLinux Server"
```

You can redirect `echo` output to a text file:

```bash
echo "Logfile started: $(date +'%D %T')" > log.txt;
```

The `+'%D %T'` parameters output the date and the time.

Check it out:

```bash
ls;
cat log.txt
```

`-n` suppresses the output of the newline character at the end. This option is
comes in handy whenever you have to create input prompts:

```bash
echo -n "Please enter a number: "; read num; echo $num;
```
