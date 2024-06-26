# The `traceroute` command

[***Table of Contents***](/README.md)

The traceroute program lists all the "hops" (hosts) network traffic takes to
get from the local system to a host:

```bash
traceroute google.com
```

You can see the number of devices it required to connect to `google.com`, those
devices' hostnames, their IP addresses, performance data in three round-trip
times. When information about a node is not provided, the field contains an
asterisk. You can use different protocols for probe packets (packets sent to
each individual host along the way (?)):

- `-T` - use TCP SYN for probes
- `-I` - use ICMP ECHO for probes
