# The `grep` command

Notes taken on the "Linux Crash Course - The grep Command" video by
LearnLinuxTV.

[***Table of Contents***](/README.md)  

`grep` stands for "global / regular expression search / and print", g/re/p.

This is how `grep` is usually used in tutorials:

    cat /etc/ssh/ssh_config | grep Port # this is redundant

`grep` options:

- `-i` - ignore case
- `-v` - invert match, print every line that *does not* contain a match
- `-c` - print the number of matches instead of the lines themselves
- `-l` - print the name of each file that contains a match instead of the lines
  themselves.
- `-L` - print the names of files that do not contain matches
- `-n` - prefix each line with the number of the line within the file
- `-h` - suppress the output of filenames
- `-r` - recursively search through files

The grep command allows us to look for specific lines in a text file. To invert
the output: 

    cat /etc/ssh/ssh_config | grep -v Port # this is redundant

It printed every line that didn't contain `Port`. 

Since the command above is redundant, the proper way is:

    grep Port /etc/ssh/ssh_config # grep <what-you-look-for> <path-to-file>

`grep` is perfectly capable of searching within files by itself.

Create a text file that contains the following lines:

    vim characters.txt

The text is:

    Name: Alan Grant    Occupation: Paleontologist   Species: Human
    Name: Batman        Occupation: Vigilante        Species: Human
    Name: Dalek         Occupation: Dalek            Species: Dalek
    Name: Doctor        Occupation: Time Traveler    Species: Time Lord
    Name: Donatello     Occupation: Ninja            Species: Mutant Turtle
    Name: Kefka         Occupation: Court Mage       Species: Human
    Name: Kirby         Occupation: Cute Pink Puff   Species: Kirby
    Name: Leonardo      Occupation: Ninja            Species: Mutant Turtle
    Name: Michelangelo  Occupation: Ninja            Species: Mutant Turtle
    Name: Raphael       Occupation: Ninja            Species: Mutant Turtle
    Name: Riddler       Occupation: Super Villian    Species: Human
    Name: Samus         Occupation: Bounty Hunger    Species: Human
    Name: Terra         Occupation: Hero             Species: Esper

Let's find all characters whose species is `Turtle`:

    grep Turtle characters.txt

You can look for `Human`s too:

    grep Human characters.txt

Reverse it for fun:

    grep -v Human characters.txt
    
Add the `-n` option:

    grep -n Human characters.txt

You now have line numbers.

To show the number of lines where your search term appears:

    grep -c Human characters.txt

By default, `grep` is case-sensitive. To remove case sensitivity, use `-i`:

    grep -i human characters.txt;
    grep -ci human characters.txt;
    grep -c human characters.txt;

Let's you wanted to look for a term in multiple files in a particular
directory:

    grep -n particular_term /home/user/directory/*

Let's you want to search for a particular term, you don't know the file name
it's in, you don't even know what directory that term might be in. You can
recursively search through files:

    grep -r search_term .

Let's search for errors in log files:

    grep -ri Error /var/log

The `-r` option is great.
