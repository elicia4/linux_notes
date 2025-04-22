# `hostnamectl`

[***Table of Contents***](/README.md)

It's an utility used to change the hostname and related settings on a `systemd`
system.

To check current hostname settings:

```bash
hostnamectl
# hostnamectl status
```

To set system hostname:

```bash
hostnamectl hostname <new_name> --static # static
hostnamectl hostname <new_name> --icon-name # pretty
hostnamectl hostname <new_name> --transient # transient / dynamic
```

`systemd` distinguish three different hostnames: 
1. the high-level "pretty" hostname which might include all kinds of special
   characters (e.g. "John's Laptop") 
2. the "static" hostname which is the user-configured hostname (e.g.
   "my-laptop")
3. the transient (or dynamic) hostname which is a fallback value received from
   network configuration (e.g. "node12345678"), assigned by mDNS server or DHCP
   server during run time.
If a static hostname is set to a valid value, then the transient hostname is
not used.

Additionally, the icon name and chassis can be set (see `man hostnamectl`):

```bash
hostnamectl icon-name <NAME>
hostnamectl chassis <NAME> 
```
