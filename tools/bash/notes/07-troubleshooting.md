# Troubleshooting

[***Table of Contents***](./00-contents.md)

Different types of problems (error) can occur in your scripts.

### Syntactic Errors

These involve mistyping some element of shell syntax. The shell will stop
executing whenever it encounters such an error.

This is a correct script:

```bash
#!/bin/bash 

# trouble: script to demonstrate common errors 

number=1 

if [ $number = 1 ]; then 
    echo "Number is equal to 1." 
else 
    echo "Number is not equal to 1." 
fi
```

This one is missing a quote, it's syntactically incorrect:

```bash
#!/bin/bash 

# trouble: script to demonstrate common errors 

number=1 

if [ $number = 1 ]; then 
    echo "Number is equal to 1.
else 
    echo "Number is not equal to 1." 
fi
```

An editor with syntax highlighting can help you fix syntactic errors, i.e. in
`vim`:

```vim
:syntax on
```

### Missing/Unexpected Tokens

Sometimes you might forget to complete a compound command(`if`/`while`):

```bash
#!/bin/bash 

# trouble: script to demonstrate common errors 

number=1 

if [ $number = 1 ] then # a ";" was removed here
    echo "Number is equal to 1.
else 
    echo "Number is not equal to 1." 
fi
```

### Unanticipated Expansions

Sometimes the script will run fine and other times it will fail because of the
results of an expansion:

```bash
#!/bin/bash 

# trouble: script to demonstrate common errors 

number= 

if [ $number = 1 ]; then 
    echo "Number is equal to 1." 
else 
    echo "Number is not equal to 1." 
fi
```

You will get the following error:

```bash
/home/me/bin/trouble: line 7: [: =: unary operator expected
```

The test expands to:

```bash
[  = 1 ]
```

`=` is a binary operator, but here only one argument is provided, so test
expect a unary operator. This can be corrected:

```bash
[ "$number" = 1 ]
```

In addition to string, you should use quotes for multiword string, such as
filenames.

### Logical Errors

Logical errors do not prevent the script from running, it will run, but it will
not produce the desired result, because of the problem with its *logic*:

- incorrect conditional expressions
- "off by one" errors, happen when employing loops that use counters
- unanticipated solutions, happen when the program encounters a situation
unforeseen by the programmer

### Defensive Programming

Verify assumptions when programming, carefully evaluate exit statuses of
commands, e.g.:

```bash
cd $dir_name
rm *
```

If the first command fails, what will happen? Everything in the current
directory will be deleted. How to make it better? Run the 2nd command only if
the first succeeds, also make sure that the variable expands into a single
value:

```bash
cd "$dir_name" && rm *
```

But what if `$dir_name` is unset or empty? The command will succeed and go to
the home directory of the current user and delete everything there. Check that
the directory exists:

```bash
[[ -d "$dir_name" ]] && cd "$dir_name" && rm *
```

And so on and so on.

### The Problem with Filenames

Unix allows all characters to be included in the filenames, except for `/` and
the null character. It's perfectly legal to name a file `-rf ~`. It is
therefore reasonable to precede all wildcards in your scripts with `./`, i.e.
`rm ./*`.

### Portable Filenames

To make sure that your filenames are portable between different platforms, only
use the characters from the POSIX Portable Filename Character set, those are:

- `[a-z]`, `[A-Z]`
- `[0-9]`
- `.`
- `-`, don't start filenames with it
- `_`

### Verifing Input

A program should be able to deal with anything it receives. Input must be
carefully screened to ensure that only valid input is accepted:

```bash
[[ $REPLY =~ ^[0-3]$ ]]
```

Nothing except for a single digit of 0-3 will be accepted. 

Don't get too fanatical about this though, your effort should be proportional
to the importance and the danger of the script. If you will only use it once
and do something trivial, it probably doesn't make sense to spend a day on it.

### Testing

Test often. Say you have a command that does something important. You can
`echo` it instead of running it for testing purposes:

```bash
if cd $dir_name; then
    echo rm * # TESTING
```

We also marked the lines responsible for testing with `# TESTING`. 

#### Test Cases

It's important to develop and apply good test cases. Carefully choose input
data that reflect *edge cases*. In the example above:

1. `dir_name` contains the name of an existing directory
1. `dir_name` contains the name of an nonexistent directory
1. `dir_name` is empty

In this particalar case, extensive testing is mandatory, since the potential
side effects of not testing this could be incredibly destructive. However,
don't get too fanatical about this either.


### Debugging

*The following section is weird to me. I feel like bash must have some sort of
a debugger that makes debugging a lot easier and better. Research further.*

If testing reveals a problem, this is the next step.

The first step is to find the problem area, which can be particalarly difficult
for long scripts. You can comment out sections of a scripts to see if the
problem occurs without it, if it doesn't, then it's possible that the problem
is related to the commented out section.

#### Tracing 

If the problem is logical, put `echo` statements to indicate what's happening
in certain logical cases:

```bash
if [[ -d $dir_name ]]; then
    if cd $dir_name; then
echo "deleting files" >&2 # this is it, not indented for easier removal
        rm *
```

`bash` itself also provides a method of tracing. It can be activated by adding
the `-x` argument to the shebang line:

```bash
#!/bin/bash -x
# this is it ^
number=1 

if [ $number = 1 ]; then 
    echo "number = 1" 
else 
    echo "number != 1" 
fi
```

The tracing output is prepended by `+`:

```bash
+ number=1
+ '[' 1 = 1 ']'
+ echo 'Number is equal to 1.'
number = 1
```

`+` is the default value for trace output, contained in `PS4`. It can be
adjusted for better output:

```bash
export PS4='$LINENO + '
```

```bash
5 + number=1 
7 + '[' 1 = 1 ']' 
8 + echo 'number = 1.' 
number = 1
```

To perform a trace on a selected portion of a script, rather than the entire
script, we can use the set command with the -x option:

```bash
#!/bin/bash

number=1

set -x # Turn on tracing
if [ $number = 1 ]; then 
    echo "number = 1" 
else 
    echo "number != 1" 
fi
set +x # Turn off tracing
```

#### Examining Values During Execution

It's also useful to examine values during execution. `echo $value`'s usually do
the job. Especially useful for tricky operations inside loops.
