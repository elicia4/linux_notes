# The `ip` command

[***Table of Contents***](/README.md)

The `ip` command is a networking configuration tool. It's used to
show/manipulate routing, network devices, interfaces and tunnels. It replaces
the obsolete `ifconfig` command.

To show a system's network interfaces and routing table:

```bash
ip a
```

You can (probably) see multiple interfaces there with detailed information on
them. The `lo` device is the loopback interfaces, it's a virtual interface the
system uses to "talk to itself", `eth0` is an Ethernet interface. The word `UP`
in the first line indicates that a network interface is enabled, also make sure
that a valid IP address in the `inet` field on the third line is present. For
systems that use DHCP a valid IP address in that field indicates that DHCP is
working indeed.
