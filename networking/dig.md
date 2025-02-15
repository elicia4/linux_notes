# `dig`

[***Table of Contents***](/README.md)

It's a DNS lookup utility. It's used to fetch DNS queries. You can query A
records, TXT records, response times etc. Other tools (such as `nslookup`)
exist for the same purpose.

To see if it's installed and install it:

```bash
command -v dig
pacman -S bind
```

To look up a domain name:

```bash
dig google.com
```

There should be an address record with an IP address of the website. There's
also a "TTL" (time to live) that shows the time the record will be cached for,
after it's over, the client will need to fetch it again. There's also "Query
time", it's good if the number is small, otherwise it may cause a massive
amount of slowdown.

You can of course look up subdomains as well:

```bash
dig analytics.google.com
```

If you want to find address records, `dig` without options will help.

To find email exchange (MX) records:

```bash
dig gmail.com MX
```

To find text records (TXT):

```bash
dig gmail.com TXT
```

Text records are common when you want to prove that you own a domain. SPF is a
text records that is used to validate email.

To look up a name server for a domain:

```bash
dig google.com NS
```

To use a specific DNS server for lookups:

```bash
dig @8.8.8.8 google.com # it's google's DNS
```

This is useful if you have local DNS issues, you want to use DNS caching, check
response times, etc.

To make `dig`'s responses shorter:

```bash
dig +short google.com
```

This is especially useful for scripts.

To see the TTL time in human readable format:

```bash
dig +ttlunits google.com
```
