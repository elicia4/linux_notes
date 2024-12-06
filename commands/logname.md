# `logname`

[***Table of Contents***](/README.md)

It can be used to print the name of the currently logged in user (provides the
user of the currently attached terminal):

```bash
logname
```

It similar to `whoami`, which prints out the name of the current effective
user:

```bash
whoami
```

If you run the following command, you will see that both of these commands
produce the same output:

```bash
echo "whoami: $(whoami), logname: $(logname)"
# whoami: user, logname: user
```

However, if you run the same command through `sudo`:

```bash
sudo sh -c 'echo "whoami: $(whoami), logname: $(logname)"'
# whoami: root, logname: user
```

This difference is due to the fact that `whoami` outputs the current effective
user, whereas `logname` outputs the user returned by the `getlogin()` function,
as described in the POSIX specification. 

According to the docs, `getlogin()` returns the user that's logged in on the
controlling terminal of the process, or a null pointer if this information
cannot be determined.

So:
- `logname` returns the user that's logged in on the terminal
- `whoam` returns the current effective user

`logname` provides the user of the currently attached terminal, `whoami`
provides the user associated with the current process. The distinction is
important, but not widely used.
