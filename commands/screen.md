# `screen`

[***Table of Contents***](/README.md)

`screen` allows you to run multiple shells in a single terminal. It's like
`tmux`, but more primitive. Especially useful for managing remote servers.

When you see have a running terminal on your screen (or a command is running in
any terminal), it's "attached". When it runs in the background, it's
"detached".

To run a command with `screen` ("attached"):

```bash
# screen "command" "arguments"
# e.g.:
screen top
```

To detach from the current screen without terminating it, use `<C-a> d` inside
a screen.

`-ls` To list running screens:

```bash
screen -ls
```

`-r` to attach to a screen:

```bash
screen -r id|name
```

`-dm` to run a screen in detached mode:

```bash
# screen -d -m "command" "arguments"
screen -d -m "ps" "aux"
```

`-S` to name a screen:

```bash
# screen -dms "name" "command" "arguments"
screen -dmS "top" "top"
```

To terminate a screen session, send a `quit` command to it:

```bash
# screen -XS "name" quit
screen -XS top quit
```

Alternatively, you can:
1. attach to a session
1. `<C-a> k y`
