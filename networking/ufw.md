# `ufw`

[***Table of Contents***](/README.md)

UFW - uncomplicated firewall. 

It allows you to simply set up firewall rules. The main utility UFW uses to
achieve this is `iptables`.

On Debian-based distributions, it's installed by default.

UFW is a service. Do not enable the UFW service before you've set up the
firewall rules and made sure you would have access to the server if the rules
were implemented.

*All of the following commands must be run as root.*

To view the status of `ufw` and its rules:

```bash
ufw status
```

The default `ufw` config file:

```bash
vim /etc/default/ufw
```

There, you can enable/disable IPv6, change the default policies:

```bash
IPV6=yes
# default policies
# the options are: accept, drop or reject
DEFAULT_INPUT_POLICY="DROP"
DEFAULT_OUTPUT_POLICY="ACCEPT"
DEFAULT_FORWARD_POLICY="DROP"
```

To disable `ufw`:

```bash
ufw disable
```

It's always recommended to set up a firewall from scratch. The default rules
may cause you issues later on because you just might simply miss something that
was already configured. 

To reset `ufw`:

```bash
ufw reset
```

**Make sure you will have access to the server if you reset the rules**. The
rules will be backed up if you reset them.

The default policies should be as follows:
- incoming - deny
- outgoing - allow

```bash
ufw default deny incoming
ufw default allow outgoing
```

You should now still have access to your web server since `ufw` should be
disabled. If you don't have access, check & stop the service via `systemctl`:

```bash
systemctl status ufw
systemctl stop ufw
```

After making sure that `ufw` is disabled, you can start adding your rules. Make
sure you understand: 
- what services you need to keep active
- what services you want to prevent from being accessed

For a web server, it's basically:
- 80 & 443 for HTTP/S
- 22 for SSH

```bash
ufw allow http
ufw allow https
ufw allow ssh
# FTP:
# ufw allow ftp
```

To allow a connection from a particular IP address:

```bash
ufw allow from 10.0.0.1
```

To specify a subnet:

```bash
ufw allow from 10.0.0.1/24
```

To allow a connection from a particular IP address to the SSH port:

```bash
ufw allow from 10.0.0.1 to any port 22
```

After you're done with the configurations, turn on `ufw`:

```bash
systemctl enable --now ufw
```

See the configured rules now:

```bash
ufw status
```

To display a list of numbered rules:

```bash
ufw status numbered
```

To delete a rule by its number:

```bash
ufw delete 5
```

Rules get shifted when you delete a rule, just like with `iptables`:

```bash
ufw status numbered
```

To deny connections:

```bash
ufw deny ftp
ufw deny http
ufw deny from 10.0.0.1
ufw deny from 10.0.0.1 to any port 22
```

To delete multiple rules at the same time:

```bash
# e.g., rules 2-6 (it's backwards because of rearrangement)
# -f skips the confirmation
for i in {6..2}; do ufw delete -f $i; done
```

1. Make sure you set up your default policies first
1. Explicitly define what you want to allow in (as well as deny)
1. Enable the firewall
