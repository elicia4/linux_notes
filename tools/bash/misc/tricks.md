# Bash Tricks

1. You can use `$_` or `!$` to recall the last argument of the previous command:
```bash
cd ~/Videos
ls !$
```
1. `Alt` + `.` can be used to cycle through the last argument of the previous
commands.
1. In a similar manner, `!^` can be used to recall the first argument.
1. If you want an arbitrary argument, use `!!:<number>`. For example, to recall
   the second argument, use `!!:2`. To recall the command itself, use `!!:0`.
