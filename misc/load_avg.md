# Load Average

Notes taken on [this video](https://www.youtube.com/watch?v=4bJmzHh4pg0) and
man pages.

[***Table of Contents***](/README.md)

Load averages help us understand how busy our servers or workstations are. They
represent the number of processes that need the CPU at a given time interval.

To show load averages, you can use multiple commands:

```bash
uptime # on the right
cat /proc/loadavg 
htop # top right by default
```

1. load over the past minute
1. load over the past 5 minutes
1. load over the past 15 minutes

In `/proc/loadavg` there are two more fields: 

1. two numbers separated by a slash (`/`): the number of currently runnable
   kernel scheduling entities (?) (processes, threads) and the number of kernel
   scheduling entities (?) that currently exist on the system
1. PID of the process that was most recently created

A system load average is the average number of processes that are either in a
runnable or uninterruptable state[^1]: 

- a process in a runnable state is either using the CPU or waiting to use the
CPU;
- a process in uninterruptable state is waiting for some I/O access, e.g.,
waiting for disk.

Load averages are not normalized for the number of CPUs in a system, so a load
average of 1 means a single CPU system is loaded all the time while on a 4 CPU
system it means it was idle 75% of the time.

You can understand what trend is happening by looking at these numbers. The
load average of 1 means 100% busy on a 1 core server. The percentage differs
depending on the number of CPU's. To see how many CPU's you have:

```bash
htop
cat /proc/cpuinfo # or
nproc
```

If you have 2 CPU's, 2 means that the server is 100% busy, if you have 4, 4
means that the server is 100% busy and so on. The load average number can be
bigger than the maximum number of cores, that means that your server is
overutilized.

It's recommended that you don't pay much attention to the first number,
sometimes a lot of resources are used in 1 minute. 5-minute and 15-minute load 
averages are better metrics.

A temporary load spike is no problem, but if it takes a long time it's bad. If
the load average is constantly high, you should investigate and if nothing
helps consider upgrading your CPU.

[^1]: from `man uptime`
