# Learn `tmux`

![tmux Logo](img/tmux.png)

Notes taken on the "Learn tmux" playlist by LearnLinuxTV.

[***Table of Contents***](/README.md)

These are notes on `tmux`, a terminal multiplexer.

1. Introduction(you are here).
1. [Splits and Panes](02-splits-panes.md)
1. [Window Management](03-wm.md)
1. [Sessions](04-sessions.md)
1. [Customization](05-customization.md)

### What is `tmux`?

`tmux` is a terminal multiplexer, it enables a number of terminals to be
created, accessed, and controlled from a single screen.

To see if `tmux` is installed:

```bash
command -v tmux
```

On Debian/Ubuntu:

```bash
sudo apt update; sudo apt install tmux
```

To launch `tmux`:
    
```bash
tmux
```

A bar (a footer) should've appeared at the bottom of your screen, it means that
`tmux` is running. You can enter in all the same commands in the shell you
normally would, there is no difference. If you internet connection to the
machine drops, your session stays persistent, any task you had running will
stay running. In addition, you get access to session management, tabs, splits
and so on. `tmux` will keep your session running even if your `ssh` connection
drops, it protects you from accidents. :)

Run any command, e.g.:

```bash
htop
```

Now you should send the "prefix key". Press `<CTRL+B>`. After that, click `d`.
You should get a `[detached ...]` message. You are back to your normal session,
but your `tmux` session didn't disappear. To view running sessions:

```bash
tmux list-sessions
```

It should show you that you have a session running:

> 0: 1 windows (created \<date\>) 

It is still running in the background. As long as you don't close the session 
or reboot the server, the `tmux` session will run. To reattach to the session:

```bash
tmux attach
```

As you can see, `htop` is still running as if nothing happened. 

To do anything in `tmux`, you have to first send the prefix key, by default
that's `<CTRL+B>`. Then you give `tmux` a command, by sending the prefix key
you tell `tmux` that what you're about to do should be at the attention of
`tmux` itself and not the underlying shell. For example `d` means "detach".

Practice sending the prefix key.

To exit the `tmux` session, run `exit`.
