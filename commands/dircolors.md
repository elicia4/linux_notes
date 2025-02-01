# `dircolors`

[***Table of Contents***](/README.md)

Prints information about which colors will be shown in the output of `ls`:

```bash
dircolors
```

The output provides shell commands that initialize an environment variable
`LS_COLORS`:

```bash
echo "${LS_COLORS}"
```

It's used by `ls`, `dir` & `vdir`. 

You can see individual colors rules with `tr`:

```bash
echo "${LS_COLORS}" | tr ':' '\n'
```

The first part describes which files to match and the second part if a fragment
of the ANSI color escape sequence.

You can see a list of the different colors that are used with different file
types with the help of `sed`:

```bash
echo "${LS_COLORS}" | tr ':' '\n' |
sed 's/\([^=]\+\)=\(.*\)/\x1B[\2m\1\x1B[0m/'
```

On some machines, the default `.bashrc` file contains a statement to evaluate
the output of `dircolors`.

In the GNU coreutils implementation of `dircolors` you can find a default hard
coded list of colors.

You can also specify your own colors in a separate file:

```bash
dircolors -p > my-custom-dircolors # -p = output defaults
sed -i 's/[0-9][0-9];[0-9][0-9]/37;41/g' my-custom-dircolors
ls
eval "$(dircolors -b my-custom-dircolors)"
# -b = output bash code to set LS_COLORS
ls
```
