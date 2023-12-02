# The `cut` command

Notes taken on the "Linux Crash Course - The `cut` Command" video by
LearnLinuxTV.

[***Table of Contents***](/README.md)

`cut` - remove sections from each line of files. 

Let's create a simple files to work with:

    echo "This is a simple message. So simplistic." > message.txt

Try this command:

    cut -b 1 message.txt

It printed the first character of the file. Popular `cut` command options:

- `-c`: select by character
- `-d`: select by delimiter
- `-f`: select by field

Let's try another one:

    cut -b 1,2,3,4 message.txt

You got characters 1-4. You can also use `-`:

    cut -b 1-4 message.txt

`b` stands for bytes, `c` stands for characters. In this example, they will
give the same output:

    cut -c 1-4 message.txt

This works because 1 character is 1 byte, in this case, it's the same thing.
But if your characters are more than 1 byte (they are from a different
language for example), this won't work.

The `cut` command allows us to cut a file to whatever we select.

You don't have to commit to a range or to individual bytes, you can do both:

    cut -c 1-4,6-7,9  message.txt

You can also separate a file by a field:

    cut -f 1,2 message.txt

This will print the entire message because you didn't set a delimiter, that's a
special character that you can pass to the command that tells it how to
differentiate fields. Let's set the delimiter to ` `:

    cut -d " " -f 1,2 message.txt

Now you get the first two words. 

An example of using the `cut` command in the real world:

    cut -d ":" -f 1,7 /etc/passwd

The file's delimiter is `:`.

`cut` is best used with other commands. It's a great file manipulating utility.
