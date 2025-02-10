# `iotop`

[***Table of Contents***](/README.md)

Displays a table of current I/O usage by processes or threads on the system in
a `top`-like manner:

```bash
iotop
```

The main advantage of it over `iostat` is that it shows I/O in relation to
processes.

The commands between square brackets are threads (kernel processes).

- `-o` to show processes that do I/O
- `-P` to only show processes

```bash
iotop -oP
```

Shortcuts:
- left and right arrows to change the sorting
- `p` to toggle `--processes`, only show processes (normally `iotop` shows all
threads)
- `o` to toggle `--only`, only show processes or threads actually doing I/O,
instead of showing all processes or threads
- `a` to toggle `--accumulated`, show  accumulated I/O instead of bandwidth. In
this mode, `iotop` shows the amount of I/O processes have done since `iotop`
started
- `r` to reverse the sorting order
- `q` to quit 
- `i` to change the priority of a thread or a process' thread(s) 
- any other key will force a refresh

### Details

From `man iotop`:

`iotop` displays the I/O bandwidth read and written by each process/thread. It
also displays the percentage of time the thread/process spent while swapping in
and while waiting on I/O. For each process, its I/O priority (class/level) is
shown.

In addition, the total I/O bandwidth read and written during the sampling
period is displayed at the top of the interface. 

- "Total DISK READ" and "Total DISK WRITE" represent total read and write
bandwidth between processes and kernel threads on the one side and kernel block
device subsystem on the other.

- "Actual DISK READ" and "Actual DISK WRITE" represent corresponding bandwidths
for actual disk I/O between kernel block device subsystem and underlying
hardware (HDD, SSD, etc.). 

Thus "Total" and "Actual" values may not be equal at any given moment of time
due to data caching and I/O operations reordering that take place inside Linux
kernel.
