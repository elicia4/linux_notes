# Session Management

[**Contents**](01-intro.md)

Open `tmux`. You have a new session. If you detach from a session and run
`tmux` again, you will get another session. Do that and confirm:

```bash
tmux list-sessions
```

You shouldn't run a session inside of a session. If you run `tmux attach`, you
will connect to the most recent session. To attach to a specific session, use
`-t`:

```bash
tmux attach -t <number> # -t for target
```

You can simplify `tmux list-sessions` to:

```bash
tmux ls # the abbreviated form of the same command
```

You can simplify `tmux attach` to:

```bash
tmux a
```

You can use parameters the same way:

```bash
tmux a -t <number>
```

You can rename `tmux` sessions. First attach to the session you want to rename.
Then run:

```bash
tmux rename-session my-session # the full name won't be show on the bottom
                               # pane
```

Detach from it and attach back by using the name:

```bash
tmux a -t my-session
```

There's an easier way to rename a session, do `prefix + $`.

There's also an easy way to switch between sessions, do `prefix + s`. You can
select the session by using numbers or by manually selecting the needed session
with arrows. You can see a preview as you scroll through.

Imagine you have a few clients you work with, you can create a separate session
for each one of them. You can switch between sessions without losing your place
within each. Categorize your workloads into sessions.

Practice everything.
