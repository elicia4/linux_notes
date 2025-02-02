# `hostid`

[***Table of Contents***](/README.md)

Prints out the current machine's host ID:

```bash
hostid
```

In the GNU core libs implementation of the command, all it does is call the
`gethostid ()` function, which is implemented in the glibc.

According to the man pages for the `gethostid` function, the original intended
purpose was to provide a 32-bit identifier that would be unique among all Unix
systems in existence.

The value can be based on the contents of the file at `/etc/hostid`. Otherwise,
it can be based on the current machine's IPv4 address, which could simply be
the loopback address:

```bash
hostid 
xxd /etc/hostid
```

Today, a 32-bit identifier is no longer adequate to achieve global uniqueness.
This suggest that `hostid` is a legacy POSIX feature (it was first introduced
in 1988).

However, some software such as OpenZFS still relies on `hostid`.
