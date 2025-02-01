# `who`

[***Table of Contents***](/README.md)

See who's logged in:

```bash
who
```

`-a` displays additional useful information, including the system boot time and
the current run level:

```bash
who -a
```

If you start `tmux` as another user, e.g. `postgres` in another terminal, you
will see the user in the output.

By default, `who` sources information from `/var/run/utmp`:

```bash
who -a /var/run/utmp
```

But `/var/run/wtmp` can also be specified:

```bash
who -a /var/run/utmp
```

It includes more historical information.

`who` supports many other flags to selectively display and format its output:

```bash
who -b # time of last system boot
who -d # print dead processes
who --login # print system login processes
who -p # print active processes spawned by init
who -r # print current runlevel
who -t # print last system clock change
who -T # add user's message status as +, - or ?
```
