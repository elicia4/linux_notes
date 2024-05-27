# `ps`

Notes on the "Linux Crash Course - The ps Command" video by LearnLinuxTV, the
`ps` man page, and other resources.

[***Table of Contents***](/README.md)  

`ps` allows you to see what processes are running on your server:

```sh
ps
```

There are `PID`, `TTY`, `TIME`, and `CMD` fields:

- `PID`, the process ID. It's unique between all processes
- `TTY`, "teletypewriter", the terminal the process is running inside of
- `TIME`, CPU time, the time a process has been *actively* utilizing the CPU
- `CMD`, the command that is running

Most processes run on a `TTY`, a terminal that gets input and manages the
output. A terminal is the method of interacting with the server. `pts` is a
virtual (pseudo) terminal device. A server can run multiple TTY sessions (1-7).
You can switch to them with `Ctrl-Alt-F1`-`Ctrl-Alt-F7`. 

Each function key represents a specific TTY. Processes you start on TTYs show
up in the output as `tty`, e.g. `tty2` or `tty4`. Processes you start in a
terminal emulator will show as `pts`, because they're not running in an actual
TTY, but rather a pseudo-TTY.

Without options, `ps` only shows the commands that are running by the user who
called it as part of the particular terminal session you run it in.

There are multiple styles to running the `ps` command with arguments:

- the BSD style: `ps aux`
- the Unix style: `ps -aux`
- the GNU style: `ps --quick-pid 2925`

These options can be freely intermixed, but conflicts may appear between them.

To list all processes owned by you (same EUID (effective user ID)  as `ps`), or
to list all processes when used together with the `a` option:

```sh
ps x
```

If a process was started by the system, it will show a `?` in the `TTY` field.

We also have a new column this time named `STAT`, it's short for "state".
Process state codes:

- `s` - root process or process leader;
- `S` - in interruptable sleep, which means that it's waiting for an event to
  complete, such as user input or a network packet and can't be disturbed until
  it receives that;
- `D` - in uninterruptible sleep, usually waiting for I/O (such as disk drive)
  and cannot handle additional signals;
- `R` - actively running. It's in the run queue;
- `T` - stopped. That happens when you background a process (with CTRL+Z);
- `Z` - (defunct), a "zombie" process, a child process that has terminated but
  has not (yet) been cleaned up by its parent. If it remains in list for a long
  time, it can be manually terminated;
- `<` - high-priority process, with a high niceness value. The higher the
  value, the less nice the process is;
- `N` - low-priority process, with a low niceness value;
- `W` - paging, not used anymore.

To list all processes with a terminal (`tty`) (or all processes with `x`):

```bash
ps a
```

You also get the `STAT` column. The output displays the specific files you have
opened with your text managers and other programs, so in case you have multiple
`vim` instances opened and one of them is misbehaving, you can see which one
specifically it is. The `COMMAND` field shows the actual command being run.

Let's run another variation of the `ps` command:

```sh
ps -He
```

`-H` shows the process hierarchy. The `-e` option lists all the processes that
are running on this system regardless of the controlling terminal.

There's a more visual way to do this:

```sh
ps -axjf
```

The output can be a bit large, shrink the font size if you can't see
everything. There will be characters that point to the parent processes. There
are new fields as well: `PPID`, `PGID`, and others.

- The `PPID` refers to the parent process ID. 
- The `SID` refers to the session ID, usually the same as the process that
  started the chain.
- `PGID` refers to the parent group process ID.
- `TPGID` refers to the terminal session ID with which the process is
  associated.
- `UID` is the user ID of the user that started the process. `UID` 0 = root.

The most popular variation is:

```sh
ps aux
```

`u` displays user-oriented format.

`UID` column is replaced with the `USER` column. You can also see the `%CPU`
and `%MEM` percentages of the processes. `VSZ` is virtual memory size, `RSS` is
the amount of physical memory (RAM) the process is using in KB. `START` shows
the time when the process was started, for values >24h, a date is used.

There's also the `START` timer that tells you when a particular process was
started. It may come in useful if a particular process was supposed to be
running all the time but was not. If there was a problem and the process had to
restart, the `START` date will show it.

`-C` to show processes by command name:

```bash
ps u -C nginx
```

`--sort spec` to specify  sorting  order. Choose a multi-letter key from the
*standard format specifiers*. You can precede a format specifier with `+` or
`-` to change the sorting order.

E.g. you can sort output by CPU usage:

```bash
ps aux --sort=-pcpu
```

Narrow it down further with `head`:

```bash
ps aux --sort=-pcpu | head -n 5
```

Or just reverse the order so that the most consuming processes appear on the
bottom:

```bash
ps aux --sort=+pcpu
```

To do the same with memory:

```bash
ps aux --sort=-pmem | head -n 5
```

Refer to the man page for even more details (there is a cool examples section
there as well):

```bash
man ps
```
