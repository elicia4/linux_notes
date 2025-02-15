# `nslookup`

[***Table of Contents***](/README.md)

Fetch DNS records. `dig` is an alternative tool. `nslookup` and `dig` behave
differently depending on their environment. `nslookup` is a self sufficient
tool, it doesn't use your OS's DNS lookup libraries, while `dig` does.

To look up a domain:

```bash
nslookup google.com
```

You can look up subdomains as well:

```bash
nslookup analytics.google.com
```

To look up MX records:

```bash
nslookup -query=mx gmail.com
```

To look up text records (TXT):

```bash
nslookup -query=txt gmail.com
```

Text records are usually used for temporary authentication or authorization
when you're attaching services to your domain. Whenever you need to set up
verification on your domain, you need a text record.

To find name servers for a domain:

```bash
nslookup -query=ns gmail.com
```

To look up information directly on a remote DNS server:

```bash
nslookup google.com 8.8.8.8
```

To see how long it takes for a record to be resolved:

```bash
time nslookup google.com
```
