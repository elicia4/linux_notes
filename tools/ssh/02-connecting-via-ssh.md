# Connecting via OpenSSH

[***Table of Contents***](./README.md)  

OpenSSH = SSH. OpenSSH is available on most platforms.

SSH client allows you to connect to other machines, but doesn't allow them to
connect to you. To see if you have it installed:

```bash
which ssh
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
type `yes`. Then the password. You're connected. Disconnect now, to do that,
press `Ctrl+D`or type `exit`. Show all files:

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

[***Next Note***](./03-configuring-the-openssh-client.md)
