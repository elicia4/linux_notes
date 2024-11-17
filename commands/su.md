# `su`

[***Table of Contents***](/README.md)

The command can be used to access the command prompt of another user/run a
command with substitute user and group ID. It's one of the oldest commands for
gaining elevated privileges.

By default, `su` switches to root:

```bash
su
```

Let's say you have a script that can only be launched by another user:

```bash
whoami
./script.sh
# -bash: ./script.sh: Permission denied
```

It doesn't work by default because you don't have permission. Use `su` to
become the user that can execute the script:

```bash
su user
whoami
./script.sh
# should run just fine now :)
```

To run a single command as `user`:

```bash
su user -c ps
```

These days, `sudo` is generally preferred over `su` for a number of
security-related reasons. `sudo` allows for more limited and temporary user
access.

`sudo` expects the password of the current (and likely less privileged) user ,
whereas `su` expects the password of the other (likely more privileged) user.
