# `hostname`

[***Table of Contents***](/README.md)

Prints the hostname of the current machine:

```bash
hostname
```

A host name is the name that's used to identify a particular machine on a
computer network. It's usually associated with an IP:

```bash
dig +short $(hostname)
```
`-i` prints the addresses for the host name:

```bash
hostname -i
```

It has multiple different common implementations (can be confusing). The
`coreutils` implementation only supports reading or writing a machine's
hostname. For this reason, a different implementation exists in the `nettools`
package which supports many options. On Ubuntu, the `info` page shows the
`coreutils` implementation, while `man` shows the `nettools` implementation.
