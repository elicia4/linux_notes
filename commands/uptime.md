# The `uptime` command

[***Table of Contents***](/README.md)

To see how long the system has been running (and other things):

```bash
uptime
```

The command tells you the current time, how long the system has been running,
how many users are currently logged on, and the system load averages for the
past 1, 5, and 15 minutes.

To see only the time the system has been up in a better format:

```bash
uptime -p
```

To see since when the system has been up:

```bash
uptime -s
```

This result of this command is displayed as the header of the `w` command, so
you might as well just run that.
