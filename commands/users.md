# `users`

[***Table of Contents***](/README.md)

It lists all of the users currently logged in into the system:

```bash
users
```

It can show one user multiple times if they're logged in more than once using
multiple methods, such as through `ssh` or terminal emulators.

By default, `users` reads information from the `/var/run/utmp` file:

```bash
xxd /var/run/utmp | less
```

It contains information about currently logged in users.

`/var/log/wtmp` can also be specified, it contains more information about
previously logged in users:

```bash
users /var/log/wtmp
```

It produces many more results.
