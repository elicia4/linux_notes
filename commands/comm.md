# The `comm` command

[***Table of Contents***](/README.md)

The `comm` program compares two text files and displays the lines that are
unique to each one and the lines they have in common. Create two files:

    echo "a
    b
    c
    d" > 1
    echo "b
    c
    d
    e" > 2

Compare them:

    comm 1 2

The first column displays the lines unique to the first file, the second to the
second, and the third the lines that they have in common.

You can supress columns in the `comm` output. To only show the the lines they
have in common (suppress unique lines in column 1 and 2):

    comm -12 1 2

To supress the third column:

    comm -3 1 2
