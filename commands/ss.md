# The `ss` command

[***Table of Contents***](/README.md)

The command pertains to networking, it allows you to view what's connected to
your system, open ports, sockets, what's listening etc.

As always:

```bash
command -v ss # to see that the command is installed
sudo apt install ss # to install it on a Debian-based system
```

Check out its detailed usage:

```bash
man ss
```

`ss` by itself shows all connections:

```bash
ss
```

To show TCP connections:

```bash
ss -t
```

To show listening TCP connections:

```bash
ss -lt
```

To show all UDP connections:

```bash
ss -ua
```

To show all listening UDP connections:

```bash
ss -lu
```

To show statistic regarding your network connections:

```bash
ss -s
```

To monitor the statistics:

```bash
watch ss -s
```

To show IPv4 connections:

```bash
ss -4
```

To show IPv6 connections:

```bash
ss -6
```

To show information on a particular port, in this case port `:22`, the SSH
port:

```bash
ss -at '( dport = :22 or sport = :22 )'
```
