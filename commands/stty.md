# `stty`

[***Table of Contents***](/README.md)

It's used to print or modify the current settings associated with your
terminal. Without any arguments, it prints the settings:

```bash
stty
```

The most helpful option is `sane`:

```bash
stty sane
```

It resets the terminal to all the sane defaults. Script may crash or error out
and fail to restore the terminal to a usable state, making it look weird or be
unusable. That's when `stty sane` comes to the rescue.

`-a` prints all current settings in human-readable form:

```bash
stty -a
```

You can see that your terminal likely uses a baud rate of 38,400. This number
describes the expected symbol communication rate between the physical and
emulated terminal monitor and remote UART (universal asynchronous
receiver-transmitter).

You can remove the terminal's `echo` flag:

```bash
stty -echo
```

Now whenever you type characters into the terminal, you won't be able to see
them, but you can still run commands.

You can re-enable character echoing by running:

```bash
stty echo
```

If you run a busy loop, you can press `^C` to quit:

```bash
while true; do sleep 1; done
```

If you first switch to raw terminal mode, `^C` won't work:

```bash
stty raw
while true; do sleep 1; done
```

You will have to close the terminal window.

To disable the backspace button:

```bash
stty erase f
```

To stop the prompt from returning to the left-hand side of the screen:

```bash
stty -opost
```
