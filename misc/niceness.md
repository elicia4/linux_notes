# Process Priority Tuning: `nice` and `renice`

There are notes on [this video,](https://youtu.be/VjZKvkZQm1U) man pages, and
other resources on the Internet.

[***Table of Contents***](/README.md)

You can alter the priority of proccesses. To determine running processes'
priority:

```bash
ps -l
```

`-l` is for "long format".

Run a process in the background, e.g.: `vim` -> `CTRL+z` -> `ps -l`.  
The `PRI` column shows the priority, the `NI` shows the niceness value. By
default, the priority of a process is 80, the niceness is 0. Running `nice` by
itself will return the default niceness value:

```bash
nice
```

The *higher* the niceness number, the *lower* the priority. The maximum
niceness value is `19`, the minimum is `-20`. If a process's niceness value 
19, all processes execute ahead of it, if it's -20, it executes ahead of all
other processes (with a higher niceness value). The lower the niceness, the
higher the priority.

The higher the priority value, the lower the priority:

```bash
ps -l
```

Commands that allow us to alter priorities: `nice` and `renice`. The choice of
command comes down to whether or not the process is already running. If you
want to launch a process with a specific priority right from the beginning,
use `nice`, if you want to change the priority of a running process, use
`renice`.

Note the `PID`s, you need them to change priorities. If you decrease priorities
(increase the niceness and priority values), you don't need `sudo`, if you
increase them, you do:

```bash
# sudo renice <num> -p <PID>
sudo renice -10 -p 6969
```

- `<num>` sets the niceness value to `num`, works the same as `-n <num>`;
- `-p <PID>` specifies the PID.

```bash
# note the difference in values
ps -l
# lower the priority
renice 19 -p 6969
ps -l
```

You can specify the niceness value with `-n`:

```bash
renice -n 6 -p 6969
```

To start a process with a specific niceness value:

```bash
# nice -n num command
nice -n 10 vim
```

`-n num` sets the niceness value to `num`, `command` can be substituted for
whatever command you want to run. Note that with the `nice` command, you can
omit `-n`, but the syntax is different. `-num` to apply a positive value,
`--num` to apply a negative value:

```bash
# pos
nice -10 vim
# neg
nice --10 vim
```

You're better off just using `-n` everywhere, the syntax is universal between
the two commands.
