# `journalctl`

[***Table of Contents***](/README.md)

It's a utility used to view logs of a `systemd` unit.

If called without parameters, it will show the contents of the journal
accessible to the calling user, starting with the oldest entry collected:

```bash
journalctl
```

That will print a gigantic log file.

To narrow it down, view the logs of a particular unit:

```bash
journalctl -u sshd
```

To list all units:

```bash
systemctl
```

To "follow" a particular unit (similar to `tail -f`):

```bash
journalctl -fu sshd
```

To only see 5 latest entries:

```bash
journalctl -n 5 -u sshd
```

To reverse the order (newest first):

```bash
journalctl -r -u sshd
```

### Priorities

`-p` - filter by message priorities (or priority ranges):

```bash
journalctl -p err -u sshd # err <=> 3
journalctl -p emerg..err -u sshd # emerg..err <=> 0-3
```

The log levels are the `syslog` log levels (`man 3 syslog`): 
- "emerg" (0)
- "alert" (1)
- "crit" (2)
- "err" (3)
- "warning" (4)
- "notice" (5)
- "info" (6)
- "debug" (7) 

- if a single log level is specified, all messages with this log level or a
lower (hence more important) log level are shown
- if a range is specified, all messages within the range are shown, including
both the start and the end value of the range
