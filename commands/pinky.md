# `pinky`

[***Table of Contents***](/README.md)

Display information about a given user:

```bash
pinky username
```

In the man page, it's described as a lightweight version of `finger`. `finger`
was created by Lester Earnest and first appeared around 1971 at the Stanford
Artificial Intelligence Lab. The finger protocol involves both a client and a
server application hosted on port 79.

`finger` could be described as the first social network where a `finger` client
was used to request information about people from a remote server. In 1988,
security flaws in the finger daemon were massively exploited by the famed
Morris worm. This and other security considerations lead to a decrease in
`finger`'s popularity (with a few exceptions).

The GNU coreutils implementation of `pinky` does not support the finger
protocol. Instead, it just pulls information from the local password file or
theoretically a remote directory service (both with the help of `getpwnam ()`).
