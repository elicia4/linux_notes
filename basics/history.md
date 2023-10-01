# Bash History

Notes on the video "Linux Crash Course - Bash History" by Learn Linux TV.

[***go back to README***](/README.md)  

Bash history gives you a list of command that have been run on your machine.
Note that history is per user as well as per terminal instance, so if you have
two terminals open and both logged into the same user, you would get different
`history` output from each of those terminals.

For example, you can find out what people before you did to fix a particular 
problem, or to just see how everything was configured. If you're on a new
production server and see an alert go off, you can refer to the history for
solutions. If some user's files suddenly disappeared, you can view their
command history and see exactly what happened.

To view the command history:

    history

You see indexes to the left of the commands in the history. You can call a
command with `!<comm_num>`, so to run command #255:

    !255

Say you ran a command that needed superuser privileges but forgot to use
`sudo`, you can fix it like so:

    sudo !! # !! will be substituted with the previous command

To add date and time to history output, add the following line to your
`.bashrc` file:

    HISTTIMEFORMAT="%Y-%m-%d %T "

To remove duplicate lines AND remove lines beginning with a space (` `) from
history, add another option:

    HISTCONTROL=ignoreboth

The reason you'd want to remove commands beginning with a space for history is 
that you sometimes want to hide some commands, for instance those that contain
confidential information, like passwords.

You can also see the last X commands with `history X`, let's say last 10
commands:

    history 10

Combining `history` with `grep` is incredibly useful as well, let's say you
want to see the packages that were installed:

    history | grep apt

You can press `<CTRL+r>` to search through the history, press `<CTRL+r>` again
to move backward through matched commands, `<CTRL+s>` to move forward through
matched results (might suspend your terminal in some cases, press `<CTRL+q>` to
resume). You can also do `<CTRL+p>` to go backward through your command history
and  `<CTRL+n>` to go forward through your command history.

