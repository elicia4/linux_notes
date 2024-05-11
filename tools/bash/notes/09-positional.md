# Positional Parameters

[***Table of Contents***](./00-contents.md)

These are needed to process arguments from the command line. Positional
parameters contain words on the command line, they are named from 0 to 9.

The first (`$0`) contains the first item on the command line, which is the
program being executed. The second (`$1`) contains the next argument (first
argument in relation to the command), and so forth. You can go beyond 9, but
you have to use the `${}` notation:

```bash
#!/bin/bash

# pos_arg.sh
# just throws your arguments back at ya

echo "
\$0 = $0
\$1 = $1
\$2 = $2
\$3 = $3
\$4 = $4
\$5 = $5
\$6 = $6
\$7 = $7
\$8 = $8
\$9 = $9
\${10} = ${10}"
```

### Number of Arguments

The `$#` contains the number of arguments:

```bash
echo "
\$# = $#
\$0 = $0
\$1 = $1
\$2 = $2
\$3 = $3
\$4 = $4
```

So:

```bash
./pos_arg 1 2 3
```

Gets you:

```bash
$# = 3
$0 = ./pos_arg
$1 = 1
$2 = 2
$3 = 3
$4 =
```

# `shift`

What if you have to process many parameters in a script, say 100? The `shift`
command causes all the parameters' values to decrease by 1, so when it's
executed, the value of `$2` is moved to `$1`, the value of `$3` is moved to
`$2` etc. The value of `$#` is reduced by 1 as well.

Try this script out!

```bash
#!/bin/bash 

# shift_args

count=1 

while [[ $# -gt 0 ]]; do 
    echo "Argument $count = $1" 
    count=$((count + 1)) 
    shift 
done
```

```bash
./shift_args 1 2 3 4
```

# `basename`

Notice how `$0` always contains a path? To fix that:

```bash
echo "\$0 = $(basename $0)
```

# Help for Your Own Functions

Take a look at this:

```bash
help_script() { 

    if [[ -e "$1" ]]; then 
        echo "the first argument exists"
    else 
        echo "$FUNCNAME: usage: $FUNCNAME file" >&2 
        return 1 
    fi 
}
```

If an argument is passed, the program will do its job, if not, it will display
a help message. The `$FUNCNAME` variable contains the name of currently
executed shell function.

### Handling Positional Parameters as a Group

Two special parameters allow you to do that:

- `$*` - expands into the list of positional parameters, starting with 1. When
surrounded by double quotes, it expands into a double-quoted string containing
all of the positional parameters, each separated by the first character of the
IFS shell variable (by default a space character).
- `$@` - expands into the list of positional parameters, starting with 1. When
surrounded by double quotes, it expands each positional parameter into a
separate word as if it was surrounded by double quotes.

This is best illustrated with an example:

```bash
#!/bin/bash 
# posit-params3: script to demonstrate $* and $@ 

print_params () { 
    echo "\$1 = $1" 
    echo "\$2 = $2" 
    echo "\$3 = $3" 
    echo "\$4 = $4" 
} 

pass_params () { 
    echo -e "\n" '$* :';   print_params $* 
    echo -e "\n" '"$*" :'; print_params "$*" 
    echo -e "\n" '$@ :';   print_params $@ 
    echo -e "\n" '"$@" :'; print_params "$@" 
} 

pass_params "word" "words with spaces"
```

This gets you:

```bash

 $* : 
$1 = word 
$2 = words 
$3 = with 
$4 = spaces 

 "$*" : 
$1 = word words with spaces 
$2 = 
$3 = 
$4 = 

 $@ : 
$1 = word 
$2 = words 
$3 = with 
$4 = spaces 

 "$@" : 
$1 = word 
$2 = words with spaces 
$3 = 
$4 = 
```

`"$*"` produces a one-word result:

```
"word words with spaces"
```

`"$@"` produces a two-word result:

```
"word" "words with spaces"
```

`"$@"` is most useful.

[***Next Note***](./10-for.md)
