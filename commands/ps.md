# The "ps" command

Notes on the video "Linux Crash Course - The ps Command" by LearnLinuxTV.

[***go back to README***](/README.md)  

The `ps` command allows you to see what processes are running on your server.

Run the `ps` command by itself:

```sh
ps
```

There will be `PID`, `TTY`, `TIME` and `CMD` columns.  
- `PID` is process ID. It's unique between all processes
- `TTY` refercs to the terminal the process is running inside of
- `TIME` refers to the CPU time, how much time a process has been utilizing the
  CPU
- `CMD` shows us the command that is running

Without options, `ps` only shows the commands that are running as part of the 
particular terminal session you run it in.

There are multiple styles to running the `ps` command with arguments:
- the BSD style: `ps aux`
- the Unix style: `ps -aux`
- the GNU style: `ps --quick-pid 2925`

To see system-wide processes:

```sh
ps x
```

If a process was started by the system, it will show a `?` in the `TTY` field.
We also have a new column this time named `STAT`.
- `s` means root process or process leader.
- `S` means that the process is running in uninterruptible sleep, which means
  that it's waiting for user input and can't be disturbed until it receives
  that.
- `R` means that it's actively running.
- `T` means the process is stopped. That happens when you background a process
  (with CTRL+Z)

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

`UID` column is replaces with the `USER` column. You can also see the `%CPU` and
`%MEM` percentages of the processes. 

There's also the `START` timer that tells you when a particular process was
started. It may come in useful if, for instance, a particular process was
supposed to be running all the time but was not. If there was a problem and the
process had to restart, the `START` date show it.
