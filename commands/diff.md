# The `diff` command

Notes taken on the "Linux Crash Course - The `diff` Command" video by
LearnLinuxTV.

[***go back to README***](/README.md)

It's the command you can use to find the difference between files. For
practice, create two slightly different text files:

    echo "I like\ndogs and cats" > 1.txt;
    echo "I like\ncats and dogs" > 2.txt;
    cp 1.txt 3.txt;
    cat 1.txt 2.txt 3.txt;

To show the difference:

    diff 1.txt 3.txt

If there's no output at all, there's no difference, in this case, the exit code
should be 0. To show the exit code:

    echo $? # if the command was successful, the code should be 0

To make the output a bit more verbose:

    diff -s 1.txt 3.txt

You can look at the changes between the backup config files and current config
files:

    diff /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

### `diff` Output

An example of an output:
> 15c15
> \< Port 2222
> ---
> \> #Port 22

- `<` relates to the the first file, `>` to the second;
- `15c15`
    - The first number refers to the line number of the first file
    - `c` stands for "changing"
    - The seconds number refers to the line number of the second file

There are some additional options not shown in the output example above.
- `d` stands for deletion, a line was removed
- `a` stands for adding, a line was added

You can colorize the output of `diff` with the `colordiff` package, install it
if you don't have it, it makes the output more clear. It's a wrapper around the
`diff` command, it doesn't change the command itself, it just colorizes the 
output:

    colordiff 1.txt 2.txt

There is the `-u` option that formats the `diff` output a bit differently, in 
my opinion, it's clearer to read:

    diff -u 1.txt 2.txt

Or even better:

    colordiff -u 1.txt 2.txt | less
