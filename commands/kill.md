# `kill`

[***Table of Contents***](/README.md)

By default, the command is used to terminate processes:

```bash
xlogo &
# [1] 132
kill 132 # kill %1 would work too
# [1]    132 terminated  xlogo
```

You can specify the process you want to kill with either its PID or its
jobspec.

What the command does is send processes signals, it's one of the ways the OS
interacts with programs. When you use `CTRL-z`, you send a `TSTP`, or "terminal
stop" signal to the process, in case of `CTRL-c` it's an `INT`, or an
"interrupt" signal. Programs actively listen for these signals, allowing them
to act accordingly. You can specify a signal like so:

```bash
kill -signal PID|name
```

Signals may be specified either by number or by name, including the name
prefixed with the letters "SIG":

```bash
# all three of these do the same thing
kill -1 process
kill -INT process
kill -SIGINT process
```

If you don't know the PID of a program, you can find out with `pidof`:

```bash
pidof nvim
```

You can also target multiple processes with `kill`:

```bash
kill -9 <p1> <p2> ...
```

Without any options, the `TERM` (terminate) signal is sent. The most commonly
used signals are:

- 1, `HUP`, Hangup.  
  The signal is used to tell programs that the controlling terminal has "hung
  up." The effect of this signal can be demonstrated by closing a terminal
  session. The foreground program running on the terminal will be sent the
  signal and will terminate. This signal is also used by daemons to cause a
  reinitialization. When a daemon is sent this signal, it will restart and
  reread its configuration file. You can use it yourself to reinitialize a
  file.

- 2, `INT`, Interrupt.  
  This performs the same function as a `Ctrl-c` sent from the terminal. It will
  usually terminate a program.

- 9, `KILL`, Kill.  
  `KILL` is never actually sent to the target program, the kernel itself
  immediately terminates the process. When a process is terminated this way,
  it's not given an opportunity to "clean up" after itself or save its work.
  Thus the `KILL` signal should be used only as a last resort when other
  termination signals fail.

- 15, `TERM`, Terminate.  
  This is the default `kill` signal. If a program is still "alive" enough to
  receive signals, it will terminate. The program is a given an opportunity to 
  clean up after itself.

- 18, `CONT`, Continue.  
  This will restore a process after a `STOP` or `TSTP` signal. This signal is
  sent by the `bg` and `fg` commands.

- 19, `STOP`, Stop.  
  This signal causes a process to pause without terminating. Like the `KILL`
  signal, it is not sent to the target process, but to the kernel, and thus it 
  cannot be ignored.

- 20, `TSTP`, Terminal stop.  
  This is the signal sent by the terminal when `Ctrl-z` is pressed. Unlike the
  `STOP` signal, the `TSTP` signal is received by the program, but the program
  may choose to ignore it.

There are other common signals:

- 3, `QUIT`, Quit.

There's an interesting use case for this one. Say you have a remote machine
with GNOME and it won't restart. You can `ssh` into the machine and `ssh -3
<gnome_shell>` and it will restart.

- 11, `SEGV`, Segmentation violation.  
  This signal is sent if a program makes illegal use of memory, if it tried to
  write somewhere it was not allowed to write.

- 28, `WINCH`, Window change.  
  This is the signal sent by the system when a window changes size. Some
  programs, such as `top` and `less` will respond to this signal by redrawing
  themselves to fit the new window dimensions.

To view a complete list of signals:

```bash
kill -l
```

Or view the man page:

```bash
man 7 signal
```

### `killall`

You can send signals to multiple processes with `killall` *matching a specified
program or username*:

```bash
killall [-u user] [-signal] name...
```

Start a couple instances of `xlogo` and terminate all of them at the same time:

```bash
xlogo &
xlogo &
killall xlogo
```

You can kill all processes that belong to a user:

```bash
killall -u username
```
