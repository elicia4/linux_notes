# `host`

[***Table of Contents***](/README.md)

`host` is a DNS lookup utility. 

To perform a lookup:

```bash
host google.com
# host <IP>
```

`-a` to see more detailed information about a host:

```bash
host -a google.com
```

`-t` to query for a particular type of record:

```bash
host -t ns google.com # ns
host -t soa google.com # soa
host -t txt google.com # txt
host -t mx google.com # mx
```

`-W` to set the length of the wait timeout:

```bash
host -W 2 google.com
```
