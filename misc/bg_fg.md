# Background and Foreground 

Notes on the video "Linux Crash Course: Background (bg) and Foreground (fg)" by
LearnLinuxTV.

[***Table of Contents***](/README.md)  

You can put programs to the background and foreground on Linux. This is
especially useful while managing a remote server.

When you run a command, you run a foreground task, e.g.:

```bash
sudo apt update
```

You run a command and it produces output. The majority of commands interact
with standard output and are foreground jobs.

To see how to work with background, install and run `htop`:

```bash
sudo apt install htop; htop
```

Useful `htop` tip: if your machine is running slowly, run `htop` and look at
the `CPU%` and `MEM%` fields. Anyway, imagine that while you do that somebody
tells to install a package, and you don't want to close `htop`.

In that case, you can **stop** it and put it to the background with `CTRL+z`.
Install your package, and then go back to `htop` with:

```bash
fg
```

You can do this with any process, e.g., while editing a config file and
switching to another task:

```bash
sudo vim /etc/ssh/sshd_config
```

If some task came up while you were editing a file, and you don't want to save
it yet (if it's incomplete for instance), put it to the background!

CRUCIAL NOTE: a background process doesn't survive shell logout. 

Another note: Many distros don't allow `nano` to be backgrounded, so be careful
with that.

You can also background a command right away with `&`:

```bash
htop &
```

To view background jobs:

```bash
jobs
```

If you have multiple jobs in the background and you `fg`, the most recently
backgrounded task will come up. 

To bring back a specific program, run `fg` with the job number (called
*jobspec*):

```bash
fg 1
```

If you use `zsh`, `fg N` will not work, use this instead:

```bash
fg %1
```

There's a simpler way (`fg` is assumed):
    
```bash
%1
```

You can *resume** the program's execution in the background with the `bg`
command:

```bash
bg %1    
```

Background jobs are the jobs you can't see, the foreground jobs are the ones
that are right before your eyes.

It is also worth noting that running GUI programs from the CLI can be very
useful, since you might be able to see error messages that would otherwise be
invisible.

To get even more control over your shell sessions, learn `tmux` or `screen`.
