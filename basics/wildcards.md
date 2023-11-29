# Wildcards / Globbing

[***go back to README***](/README.md)  

Wildcards are special characters that help us specify groups of filenames.
Using wildcards (which is also known as globbing) allows us to select filenames
based on patterns of characters.

Wildcards:

- `*` matches any characters
- `?` matches any single character
- `[characters]` matches any character that is a member of the set `characters`
- `[!characters]` matches any character that is not a member of the set
  characters
- `[[:class:]]` matches any character that is a member of the specified class

Character classes:

- `[:alnum:]` matches any alphanumeric character
- `[:alpha:]` matches any alphabetic character
- `[:digit:]` matches any numeral
- `[:lower:]` matches any lowercase letter
- `[:upper:]` matches any uppercase letter

## Expansion

The mechanism by which wildcards work is called *pathname expansion*. To list
all files beginning with an uppercase character:

    echo [[:upper:]]*

You can look up files with a particular directory structure like so:

    echo ~/*/bin
    echo /usr/*/share

The tilde (`~`) character expands into the name of the home directory of the
current user or a user specified right after `~`:

    echo ~
    echo ~user

You can do simple integer math with `$((expression))`:
    
    echo $((2 + 3))

Single parentheses can be used to group multiple subexpressions:

    echo $((2 + (2**3)))

You can create multiple text strings with the help of braces:

    echo file_{001,002,003}.mpv
    # expands to file_001.mpv file_002.mpv file_003.mpv

The leading `file_` part is called a preamble and the trailing `.mpv` is called
a postscript.

You can create zero-padded integers like so:

    echo {01..15}
    # gets you 01 02 03 04 ... 15
    echo {001...15}
    # evaluates too 001 002 003 ... 015

You can nest brace expansions:

    echo {a{1,2},b{1,2}}
    # evaluates to a1 a2 b1 b2

You can output characters in reverse order as well:

    echo {Z..A}
    # gets you Z Y X ... C B A

Here's a practical example of creating a directory structure with a
**YEAR-MONTH** format:

    mkdir {2023..2054}-{1..12}
    # 2023-1 2023-2 ... 2054-11 2054-12

Or a directory structure in the home directory:

    mkdir /home/{user1, user2, user3}/{dir1, dir2, dir3}/super_dir
    # /home/user1/dir1/super_dir ... /home/user3/dir3/super_dir

### Command Substitution

It allows you to use the output of a command in a command:

    ls -l $(which mv)

It evaluates the path to the `mv` file first and then gives a long listing of
it.

You can substitute `$()` with backquotes (\`\`):

    ls -l `which mv`

To supress all expansion, you can use single quotes:

    echo '$PATH equals to' "$PATH"
    # $PATH in single quotes is supressed, $PATH in double quotes isn't
