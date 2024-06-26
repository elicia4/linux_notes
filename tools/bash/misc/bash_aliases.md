# Bash Aliases

Notes on the video "Linux Crash Course - Bash Aliases" by LearnLinuxTV.

[***Table of Contents***](/README.md)  

To create an alias:

```bash
alias mycmd="ls -lh"
```

When you call `mycmd`, `ls -lh` will be executed. You can name your alias
whatever you want, even make it be one character long:

```bash
alias l="ls -lh"
```

To view all your aliases:

```bash
alias
```
    
Various distributions will give you some aliases by default, so the output of
`alias` may be big.

To remove an alias:

```bash
unalias mycmd
unalias l 
```

Let's take a look at some useful aliases. 

We can simplify the output of `df -h`. The `df` command allows you to see how
much storage you have available. Let's name it `df`, so that it overwrites the 
original command (you can name it whatever else if you don't want that):

```bash
alias df="df -h -x squashfs -x tmpfs -x devtmpfs"
```

The `-x` option exlcudes. To view the alias:

```bash
alias df
```

If you execute it:

```bash
df
```

There will be fewer lines of output, it will be a lot simpler.

Let's take a look at `mount` now. If you run it with the default options, you
will get tons of output, it will be quite hard to read. Make an alias:

```bash
alias lsmount="mount | column -t"
```

Run it, things will be a lot cleaner:

```bash
lsmount
```

The output is in columns, it's a lot easier to digest.

Make an alias to show your external IP:

```bash
alias extip="curl icanhazip.com"
```

You can simplify the process of installing packages. For `apt`:

```bash
alias install="sudo apt install"
```
    
For `pacman`:

```bash
alias install="pacman -S"
```

You can simplify it even further by making it `i` instead of `install`:

```bash
alias i="pacman -S"
```

You can now install packages easily:

```bash
i tmux
```

You can simplify the command for upgrading packages:

```bash
alias upgrade="sudo apt update && sudo apt dist-upgrade"
```

Or for `pacman`:

```bash
alias upgrade="pacman -Syyu"
```

Set an alias for running a speedtest:

```bash
alias speedtest="curl -s \
https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py \
| python3 -"
```

To show top 5 processes that use the most memory/CPU:

```bash
alias mem5='ps auxf | sort -nr -k 4 | head -5';
alias cpu5='ps auxf | sort -nr -k 3 | head -5'
```

To show the top 10 most-CPU/memory-consuming processes:

```bash
alias cpu10='ps -L aux | sort -nr -k 3 | head -10'
alias mem10='ps -L aux | sort -nr -k 4 | head -10'
```

View all mounted filesystems, and present the information in a clean tabbed
yout:

```bash
alias lsmount='mount | column -t'
```

Clear the screen by simply typing `c`:

```bash
alias c=clear
```

Note that all these aliases are specific to the current shell. To set them
system-wide, add them to your `.bashrc` (or whatever other config file for your
shell).

```bash
vim ~/.bashrc
```

Pro tip: to temporarily bypass an alias, use `\`:

```bash
\df
```
