# `nftables`

[***Table of Contents***](/README.md)

It's a yet another packet filtering application (firewall). Many distributions
support it, such as Debian, Arch, Ubuntu and Fedora. It's really efficient at
filtering traffic.

On Debian:

```bash
apt install nftables
systemctl enable --now nftables.service
```

To flush all the rules:

```bash
nft flush ruleset
```

To show current rules:

```bash
nft list ruleset
```

`nftables` uses tables to store chains. The chains contain filtering rules.
Each table must have an address family assigned. It defines the packet types
this table processes:
- `ip` - IPv4 packets (default)
- `ip6` - IPv6 packets
- `inet` - IPv4 and IPv6 packets
- `arp` - IPv4 ARP packets
- `bridge` - packets that pass through a bridge device
- `netdev` - ingress packets 

To create a table:

```bash
nft add table <table_address_family> <table_name>
```

Tables consist of chains. Chains consist of rules. 

There are two types of chains:
- base chain: entry points for packets from the networking stack
- regular chain: `jump` target to better organize rules

To create a base chain:

```bash
nft add chain <table_address_family> <table_name> <chain_name> { \
  type <type> hook <hook> priority <priority> \; policy <policy> \; }
```

To create a regular chain:

```bash
nft add chain <table_address_family> <table_name> <chain_name> { }
```

### Editing the Config File

The default config file is located at `/etc/nftables.conf`. It's what runs on
startup. Here's a basic setup:

```bash
#!/usr/sbin/nft -f

# flushes the existing rules
flush ruleset

# inet: IPv4 and IPv6 packets
table inet firewall {
    chain input {
        # drop everything 
        type filter hook input priority 0;
        policy drop;

        # accept ICMP & discovery (set a rate limit of 5/s)
        icmp type echo-request limit rate 5/second accept;
        icmpv6 type echo-request limit rate 5/second accept;

        # accept neighbor discovery
        icmpv6 type { nd-neighbor-solicit, nd-router-advert, nd-neighbor-advert } accept;

        # allow loopback
        iifname lo accept;

        # allow traffic from established & related packets, drop invalid
        # ct state vmap { established : accept, related : accept, invalid : drop };

        # allow established & related packets
        ct state established,related accept;

        # invalid connections
        ct state invalid drop;

        # allow allow HTTP(S) TCP/80 and TCP/443 for IPv4 and IPv6
        tcp dport {80, 443} accept;
        # tcp dport {http, https} accept; # also works

        # you can specify port ranges as well
        # tcp dport {1-1024} reject with tcp reset;
        # udp dport 53 reject with icmp type port-unreachable;

        # to allow SSH from specific hosts
        tcp dport 22 ip saddr 192.168.0.0/16 accept;
        tcp dport 22 ip saddr 172.16.0.0/12 accept;
        tcp dport 22 ip saddr 10.0.0.0/8 accept;
    }

    chain forward {
        # drop everything since this is not a router
        type filter hook forward priority 0;
        policy drop;
    }

    # there's really no need to define this, the default policy is accept
    chain output {
        type filter hook output priority 0;
        policy accept;
        # you can disable outbound ssh connections
        # tcp dport ssh reject with icmp type host-unreachable;
    }
}
```

Everything has to be in tabbed positions.

To apply it, do either one of these:

```bash
nft -f /etc/nftables.conf
```
```bash
systemctl restart nftables.service
```

To see the current ruleset:

```bash
nft list ruleset
```
