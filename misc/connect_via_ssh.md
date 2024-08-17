# Connecting to Linux Servers via SSH

Notes taken on the [Linux Crash Course - Connecting to Linux Servers via SSH video by LearnLinuxTV.](https://www.youtube.com/watch?v=kjFz7Lp8Qjk)

[***Table of Contents***](/README.md)

You need a server you can connect to first, set up a WM, look up it's IP. 

SSH has two components: client and server. SSH client is installed by default
on the majority of distributions (if not all of them).

To make sure:

```bash
which ssh
```

If you got output, you have SSH installed.

To connect:

```bash
ssh <user>@<address>
# ssh user@192.168.0.1
```

In the prompt, enter `yes`. It comes up the first time you connect to a
particular server. 

You can now run commands, for example:

```bash
sudo apt update # update the package repository index on Debian
```

It should work. Do whatever you want. After you're done with your session, you
should disconnect:

```bash
exit
```

The reason you may not be able to connect to a server can be that its port
number is different from the default one (22). To specify a port:

```bash
ssh -p <PORT> <user>@<IP>
# ssh -p 2222 user@192.168.0.1
```

There's some value in changing the default port, but not much, when it comes to
security, it's the first thing people usually try when they attempt to break
into your server.

You can remove the `<user>` parameter if your current username is the same as
the remote one:

```bash
ssh <address>
```
