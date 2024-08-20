# Connecting via OpenSSH

[***Table of Contents***](./README.md)  

OpenSSH = SSH. OpenSSH is available on most platforms.

You need a server you can connect to first, set up a WM, look up it's IP. 

SSH has two components: client and server. SSH client is installed by default
on the majority of distributions (if not all of them). The client allows you to
connect to other machines, but doesn't allow them to connect to you. To see if
you have `ssh` installed:

```bash
which ssh # if you got output here, it's installed
```

SSH client package is usually installed by default. On Debian-based systems you
can search for it with:

```bash
apt search openssh-client
```

In the square brackets on the right, it will tell you if it's installed or
not[^1].

[^1]: Square brackets won't be there if it's not.

Set up an instance of a remote server (or a VM). You can connect to it with
`ssh`:

```bash
ssh <username>@<IP>
```

You will get a prompt asking whether you're sure you want to connect or not,
type `yes`. Then the password. You're connected. 

You can now run commands, e.g.:

```bash
sudo apt update # update the package repository index on Debian
```

It should work. After you're done with your session, you can disconnect with
`<Ctrl+d>` or `exit`. 

Now show all files:

```bash
ls -a
```

You have a new `.ssh` directory. Take a look at the file `known_hosts` inside
it:

```bash
cat known_hosts
```

Reconnect to the server. Notice that you weren't asked whether you wanted to
connect this time. That's because your *fingerprint* is now stored in the 
`known_hosts` file. If you remove the file, you will be asked again. You local
SSH client keeps track of the connected servers with the `known_hosts` file.
Why is this important? It helps to avoid the man-in-the-middle attack. If a
malicious server is set up, you will be warned that the fingerprint was
changed.

One reason you may not be able to connect to a server can be that its port
number is different from the default one (22). To specify a port:

```bash
ssh -p <PORT> <user>@<IP>
# ssh -p 2222 user@192.168.0.1
```

There's some value in changing the default port, but not much. When it comes to
security, it's the first thing people usually try when they attempt to break
into your server.

You can remove the `<user>` parameter if you want to connect with the current
username:

```bash
ssh <address>
```

To follow the authorization log on the server:

```bash
tail -f /var/log/auth.log 
```

Then connect to the server from your client. The log file is going to say that
it:

```
Accepted password for <username> from <IP> port <port-number>
```

and that the `session opened for user <username> ...`.  If a user can't connect
with `ssh`, you will know the exact reason why they can't.

You can connect with a non-default shell with the `-t` option:

```bash
ssh <user>@<host> -p <port> -t /bin/sh
```

[***Next Note***](./03-configuring-the-openssh-client.md)
