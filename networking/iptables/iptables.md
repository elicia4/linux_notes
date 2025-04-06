# `iptables`

[***Table of Contents***](/README.md)

`iptables` is an administration tool used for IPv4/IPv6 packet filtering and
NAT. It is a firewall.

### `iptables`

| Filter Table | NAT Table | Mangle Table |
| :---------------: | :---------------: | :---------------: |
| Input Chain | Output Chain | Input Chain |
| Output Chain | Prerouting Chain | Output Chain |
| Forward Chain | Postrouting Chain | Forward Chain |
|       |       | Prerouting Chain |
|       |       | Postrouting Chain |

Netfilter on Linux is a firewall framework. `iptables` is a utility used to
manage and control netfilter. `iptables` is not just responsible for filtering
traffic, but it also deals with NAT, modifying packets, acting as a router,
etc.

`iptables` can be used to filter both incoming and outgoing packets, as well as
route packet on a network.

A table within `iptables` is a collection of chains that serves a particular
function / is responsible for handling a certain aspect of networking.

1. The filter table is responsible for filtering outgoing and incoming traffic.
   Deals with the firewall aspect.
1. The NAT table is used to redirect connections to other interfaces within a
   network.
1. The mangle table deals with modifying a packet or a connection.

We will mostly deal with the filter table.

Chains are tags that define and match packets to their state. E.g., in the
filter table you have:
1. The input chain
1. The output chain
1. The forward chain

Each of them is used to process packets based on their type. 
1. The input chain processes packets sent into the target, i.e. deals with
   ingress traffic
1. Packets that are send out of your server are processed by the output chain,
   i.e. deals with egress traffic
1. Packets that are forwarded from one computer to another using your computer
   are processed by the forward chain

- The prerouting chain is used right after a packet has entered the network
interface.
- The postrouting chain is used before the packet leaves the network interface
after the routing decision has been made.

### The Input Chain

Within a chain you have all your rules. The rules are numbered. Each packet is
tested against the rules sequentially (1-N). 

Targets refer to what's going to happen to a packet once it's matched with a
particular rule.

Target are:
- accept - stop processing, allow the packet to flow into the service it was
intended for
- reject - drop the packet, send feedback to the user
- drop - drop the packet, send no feedback

By default, if a packet gets into the server and does not match any rules, it
will be accepted by the system.

### Installations & Distributions

By default, CentOS uses `firewalld`. Ubuntu/Debian uses `ufw`.

If you only want to use `iptables`, it is imperative that you uninstall them
completely because they are all interfaces for `iptables`. They all include
various rules that interfere with `iptables`.

On Ubuntu:

```bash
apt purge ufw
```

Make sure to flush the `iptables` rules to reset the rules:

```bash
iptables -F
```

If it's not installed, you can do:

```bash
sudo apt install iptables
systemctl enable --now iptables.service
```

### Commands

To list all of the rules for a particular table. By default, the FILTER table
is used:

```bash
iptables -L
```

This option is often used with `-n` to avoid long reverse DNS lookups:

```bash
iptables -nL
```

To also show more information, use `-v` (see `man iptables`):

```bash
iptables -vnL
```

To list the rules with line numbers:

```bash
iptables -vnL --line-numbers
```

If you're beginner, don't use `-v` so at to not get overwhelmed:

```bash
iptables -nL --line-numbers
```

You can also see what the default policy for a particular chain is.

When you start off configuring `iptables`, make sure the default policy is set
to `ACCEPT`.

To set the default policy of the `INPUT` chain to `ACCEPT`:

```bash
iptables --policy INPUT ACCEPT
```

If you're locking down your server, you can set it to `DROP`:

```bash
iptables --policy INPUT ACCEPT
```

To block an IP address from accessing a server:

```bash
# -I to add to the top of the list
# -A to add to the bottom of the list
# -s to specify the source
# -j to specify the target (ACCEPT, DROP, REJECT)
iptables -I INPUT -s 10.0.0.1 -j DROP
```

View the changes:

```bash
iptables -L
```

To specify a subnet:

```bash
iptables -I INPUT -s 10.0.0.1/24 -j DROP
```

To delete a particular rule, first list all of the rules with line numbers:

```bash
iptables -nL --line-numbers
```

Then delete the rule by its number from the chain:

```bash
iptables -D INPUT 1
```

Please note that whenever you delete a rule, *the rest of them get shifted*. So
after you delete rule N, rule N+1 gets shifted to its place, N+2 to N+1's
place, etc. E.g., if you delete rule 1, rule 2 gets shifted to position 1, thus
becoming rule 1:

```bash
iptables -nL --line-numbers
```

To block an outgoing connection:

```bash
iptables -I OUTPUT -s 10.0.0.1 -j DROP
```

To block SSH connections or connections to a web server:

```bash
# -I - specify chain
# -p - specify protocol
# --dport - specify the destination port
iptables -I INPUT -p tcp --dport 22 -j DROP
iptables -I INPUT -p tcp --dport 80 -j DROP
```

To allow access to a server for a particular host:

```bash
iptables -I INPUT -p tcp --dport 80 -s 192.168.0.1 -j ACCEPT # HTTP
iptables -I INPUT -p tcp --dport 20 -s 192.168.0.1 -j ACCEPT # SSH
```

### Saving The Rules

`iptables`'s rules are not saved by default. Therefore, whenever you reboot
your systems, the rules will be deleted.

To print the `iptables` configuration:

```bash
# sudo /sbin/iptables-save
iptables-save
```

To make them persistent, on a Debian system:

```bash
apt install iptables-persistent
iptables-save > /etc/iptables/rules.v4 # to save IPv4 rules
iptables-save > /etc/iptables/rules.v6 # to save IPv6 rules
```

To delete persistent `iptables` rules, simply delete the relevant lines in the
files above.

If you want to reset the running `iptables` configuration to its default state:

```bash
iptables -F
```
