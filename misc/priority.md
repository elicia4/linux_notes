# Process Priority Tuning: `nice` and `renice`

There are notes on [this video,](https://youtu.be/VjZKvkZQm1U) man pages, and
other resources on the Internet.

[***Table of Contents***](/README.md)

You can alter the priority of running proccesses. To determine running
processes' priority:

    ps -l

`-l` is for "long format".

Run a process in the background, e.g.: `vim` -> `CTRL+z` -> `ps -l`.  
The `PRI` column shows the priority, the `NI` shows the niceness value. By
default, the priority of a process is 80, the niceness is 0. Running `nice` by
itself will return the default niceness value:

    nice

The *higher* the niceness number, the *lower* the priority. The maximum
niceness value is `20`, the minimum is `-20`. If a process's niceness value is
20, all processes execute ahead of it, if it's -20, it executes ahead of all
other processes (with a higher niceness value). The lower the niceness, the
higher the priority.

The higher the priority value, the lower the priority:

    ps -l

Note the `PID`s, you need them to change priorities. If you decrease
priorities, you don't need `sudo`, if you increase them, you do.

    # sudo renice num -p <PID>
    sudo renice -10 -p 6969

- `num` sets the niceness value to `num`;
- `-p <PID>` specifies the PID.

    # note the difference in values
    ps -l
    # lower the priority
    renice 20 -p 6969
    ps -l

You can specify the niceness value with `-n`:

    renice -n 6 -p 6969

You can set a priority when you launch a process for the first time:

    # nice -n num command
    nice -n 10 vim

`-n num` sets the niceness value to `num`, `command` can be substituted for
whatever command you want to run. Note that with the `nice` command, you must
specify the `-n` option to set the niceness value, you *can't omit it* like you
can with `renice`.
