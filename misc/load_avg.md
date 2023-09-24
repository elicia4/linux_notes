# Load Average

Notes taken on the "How to Interpret Load Average in Linux (Linux Crash Course
Series)" video by LearnLinuxTV.

[***go back to README***](/README.md)

Load averages help us understand how busy our server or workstation happens to
be.

To show load averages, you can use multiple commands:

    uptime # on the right

    cat /proc/loadavg 

    htop # top right by default

1. The number indicates the load over the past 1 minute;
1. The number indicates the load over the past 5 minutes;
1. The number indicates the load over the past 15 minutes;

You can understand what trend is happening by looking at these numbers. The
load average of 1 means 100% busy (but it's not always the case). It depends on
how many CPU's you have on your server. To see how many CPU's you have you can 
run `htop`, if it's not there run:

    cat /proc/cpuinfo

A simpler way is to run:

    nproc

It prints the number of processing units available.

If you have 2 CPU's, 2 means that the server is 100% busy, if you have 4, 4
means that the server is 100% busy and so on. The load average number can be
bigger than the maximum number of cores, that means that your server is
overutilized.

It's recommended that you don't pay much attention to the first number,
sometimes a lot of resources are used in 1 minute. 5-minute and 15-minute load 
averages are better metrics.

A temporary load spike is no problem, but if it takes a long time it's bad. If
the load average is constantly high, you should consider upgrading your CPU(s).
