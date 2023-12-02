# The "ps" command

Notes on the video "Linux Crash Course - The ps Command" by LearnLinuxTV.

[***Table of Contents***](/README.md)  

The `ps` command allows you to see what processes are running on your server.

Run the `ps` command by itself:

```sh
ps
```

There will be `PID`, `TTY`, `TIME` and `CMD` columns.  
- `PID` is process ID. It's unique between all processes
- `TTY`, "teletype", refers to the terminal the process is running inside of
- `TIME` refers to the CPU time, how much time a process has been utilizing the
  CPU
- `CMD` shows us the command that is running

Without options, `ps` only shows the commands that are running as part of the 
particular terminal session you run it in.

There are multiple styles to running the `ps` command with arguments:
- the BSD style: `ps aux`
- the Unix style: `ps -aux`
- the GNU style: `ps --quick-pid 2925`

To see all processes regardless of what they are controlled by (the system
itself or the terminals):

```sh
ps x
```

If a process was started by the system, it will show a `?` in the `TTY` field.
We also have a new column this time named `STAT`, it's short for "state".
- `s` means root process or process leader.
- `S` means that the process is in interruptable sleep, which means that it's
  waiting for an event to complete, such as user input or a network packet and
  can't be disturbed until it receives that.
- `D` means that it's in uninterruptible sleep, usually waiting for I/O such as
  disk drive.
- `R` means that it's actively running.
- `T` means the process is stopped. That happens when you background a process
  (with CTRL+Z)
- `Z` indicates a "zombie" process, a child process that has terminated but has
  not been cleaned up by its parent.
- `<` is a high-priority process, with a high niceness value. The higher the
  value, the less nice the process is.
- `N` is a low-priority process, with a low niceness value.

Let's run another variation of the `ps` command:

```sh
ps -He
```

`-H` shows the processes in a hierarchy. The `-e` option lists all the processes
that are running on this system regardless of the controlling terminal.

There's a more visual way to do this:

```sh
ps -axjf
```

The output can be a bit large, shrink the font size if you can't see everything.
There will be characters that point to the parent processes. There are new
fields as well: `PPID`, `PGID`, and others.

- The `PPID` refers to the parent process ID. 
- The `SID` refers to the session ID, usually the same as the process that
  started the chain.
- `PGID` refers to the parent group process ID.
- `TPGID` refers to the terminal session ID with which the process is associated.
- `UID` is the user ID of the user that started the process. `UID` 0 = root.

The most popular variation is:

```sh
ps aux
```

`UID` column is replaced with the `USER` column. You can also see the `%CPU`
and `%MEM` percentages of the processes. `VSZ` is virtual memory size, `RSS` is
the amount of physical memory (RAM) the process is using in KB. `START` shows
the time when the process was started, for values >24h, a date is used.

There's also the `START` timer that tells you when a particular process was
started. It may come in useful if, for instance, a particular process was
supposed to be running all the time but was not. If there was a problem and the
process had to restart, the `START` date show it.
