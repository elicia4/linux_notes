# Prompt Customization

The format of the prompt is defined by the `PS1` environment variable:

    echo $PS1

The prompt usually contains *backslash-escaped special characters* that define
the elements of the prompt string:

- `\a` - ASCII bell. This makes the computer beep.
- `\d` - Current date in day, month, date format, e.g. "Tue March 15." 
- `\h` - Hostname without the domain name.
- `\H` - Full hostname.
- `\j` - Number of jobs running in the current shell session.
- `\l` - Name of the current terminal device.
- `\n` - A newline character.
- `\r` - A carriage return.
- `\s` - The shell program.
- `\t` - Current time in 24-hour hours:minutes:seconds format.
- `\T` - Current time in 12-hour format.
- `\@` - Current time in 12-hour AM/PM format.
- `\A` - Current time in 24-hour hours:minutes format.
- `\u` - Username of the current user.
- `\v` - Version number of the shell.
- `\V` - Version and release numbers of the shell.
- `\w` - Current working directory.
- `\W` - Last part of the current working directory name.
- `\!` - History number of the current command.
- `\#` - Number of commands entered during this shell session.
- `\$` - This displays a `$` for regular privileges, `#` for superuser.
- `\[` - Signals the start of a series of one or more non-printing characters.
  This is used to embed non-printing control characters that manipulate the
  terminal emulator in some way, such as moving the cursor or changing text
  colors.
- `\]` - Signals the end of a non-printing character sequence.

You can test your new prompt by changing the `PS1` variable in the environment:

    PS1="\u@\h \W \$ "

You can set it back by restarting the shell, sourcing the `.bashrc` file,
backing it up to another variable, or setting it back from the config file like
so:

    PS1=$(grep PS1 .bashrc | tail -c +6 | head -c -2)
    # this won't work for prompts that are configured with more than one line,
    # it should work for simple one-line prompts though

You can change character color as well by using *ANSI escape codes*, you need
escape sequences that set colors. An ANSI escape code sequence with "033",
followed by an optional character attribute and an instruction:

    \033[0;41m
    #^   ^ ^ instruction
    #|   | character attribute
    #| beginning of an ANSI escape code

To encapsulate non-printing characters, like an ANSI escape sequence, use `\[`
and `\]`. For example, to make the prompt yellow:

    PS1="\[\033[1;33m\]\u@\h \W \$ "

This way, all the text after the prompt will be yellow as well. To fix that,
you need to add another escape sequence at the end to change it to the previous
color:

    PS1="\[\033[1;33m\]\u@\h \W \$\[\033[0m\] "

Here's a list of text color escape sequences:

- `\033[0;30m` - Black
- `\033[1;30m` - Dark gray
- `\033[0;31m` - Red
- `\033[1;31m` - Light red
- `\033[0;32m` - Green
- `\033[1;32m` - Light green
- `\033[0;33m` - Brown
- `\033[1;33m` - Yellow
- `\033[0;34m` - Blue
- `\033[1;34m` - Light blue
- `\033[0;35m` - Purple
- `\033[1;35m` - Light purple
- `\033[0;36m` - Cyan
- `\033[1;36m` - Light cyan
- `\033[0;37m` - Light gray
- `\033[1;37m` - White

You can set background colors as well, use `\[\033[0;41m\]` for the red
background color.

    PS1="\[\033[1;33m\]\u\[\033[0;41m\]@\[\033[1;33m\]\h \W \$\[\033[0m\] "

This is a list of background color escape codes:

- `\033[0;40m` - Black
- `\033[0;44m` - Blue
- `\033[0;41m` - Red
- `\033[0;45m` - Purple
- `\033[0;42m` - Green
- `\033[0;46m` - Cyan
- `\033[0;43m` - Brown
- `\033[0;47m` - Light gray

You can set different character attributes:

- 0 - normal
- 1 - bold
- 4 - underscore
- 5 - blinking (usually not supported)
- 7 - inverse

You can position the cursor with escape sequences:

    PS1="\[\033[s\033[0;0H\033[0;45m\033[K\033[1;36m\t\033[0m\033[u\]
    \u@\h \W\$ "

These are cursor movement sequences:

- `\033[l;cH` - Cursor to line `l` and column `c`
- `\033[nA` - Cursor up `n` lines
- `\033[nB` - Cursor down `n` lines
- `\033[nC` - Cursor forward `n` characters
- `\033[nD` - Cursor backward `n` characters
- `\033[2J` - Clear the screen and move the cursor to the upper-left corner
- `\033[K` - Clear from the cursor to the end of the current line
- `\033[s` - Store the current cursor position
- `\033[u` - Recall the stored cursor position

To save the prompt, add it to `~/.bashrc` like so:

    PS1="your prompt here "
    export PS1
