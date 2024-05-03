# The `netstat` command

[***Table of Contents***](/README.md)

The `netstat` is also used to examine network configurations and statistics,
such as network connections, routing tables, interface statistics, masquerade
connections, and multicast memberships.

To display all network interfaces (`-i`) with additional information (`-e`):

    netstat -ie

To display the kernel's network routing table:
    
    netstat -r

This shows how the network sends packets from network to network.
- `Destination` - destination IP address
- `Gateway` - name or IP address of the gateway (router) used to go from the
  current host to the destination network, an asterisk indicates that no
  gateway is needed

The `default` destination indicates any traffic destined for a network that is
not listed in the table.

You can view open ports as well:

```bash
sudo netstat -tulpn
```

- `-tu` - TCP/UDP
- `-l` - show listening sockets
- `-p` - show the PID and name of the program to which each socket belongs.  A
hyphen is shown if the socket belongs to the kernel. Won't be shown w/o `sudo`
- `-n` - Unless the --numeric (-n) option is specified, the socket address  is
resolved  to its canonical host name (FQDN), and the port number is translated
into the corresponding service name.
