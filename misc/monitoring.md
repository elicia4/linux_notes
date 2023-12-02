# Monitoring on Linux

[***go back to README***](/README.md)  

There are many monitoring tools on Linux:

- [top](../commands/top.md), a great interactive CLI tool
- [htop](../commands/htop.md), a newer, better version of `top`
- [ps](../commands/ps.md), a program that displays detailed information about
  active processes, supports *many* options

Some other monitoring commands are:
- `pstree` displays a tree of processes
- `vmstat` displays system resource usage including, memory, swap, and disk
  I/O. To see a continuous display, follow the command with a time delay, you
  can also change the default display unit with `-S`:

      vmstat -S M 3

- `xload` is graphical program that draws a graph showing system load over time
- `tload` is a TUI alternative to `xload`
