### Troubleshooting SSH

[***Table of Contents***](README.md)  

SSH will only be able to work if there's a path between the client and the 
server. Every single node between them has to allow traffic, and if anything 
fails along the way your connection won't be established.

You have to have the `openssh` client installed on your computer. All modern
Linux distributions have `ssh-client` installed by default, MacOS also has it
by default and it's very easy to install on Windows.

Assuming your ISP doesn't have port 22 blocked, which very rare but it does 
happen you should have no trouble getting out of your LAN out to the Internet,
that's the easiest part. When you get to the remote server, the remote device
has to allow traffic on port 22. Most often it will accept all traffic. You
have to have 22 allowed straight through.

Most common errors you might get:

1) Invalid permissions. The `.ssh` directory should only be viewable, readable
and executable by YOU and no one else. The public keys inside should be
readable by everybody, the private keys only by YOU. If you set permissions to
something else, SSH will not work. If you cannot connect, check your
permissions! You may or may not get an error that permissions are the problem. 
When it comes to the remote end, you want to make sure to check the same thing.

2) Take a look at the log file:

```
cd /var/log 
tail -f auth.log 
```

You can have a user try to connect and look at the logs to find the issue.
Tailing is actually the old way of doing things, try using `journalctl`
instead!
    
    journalctl -u sshd

You can also follow the log entries with the `-f` option:

    journalctl -fu sshd

This is the equivalent of `tail -f` but with `journalctl`.

`ssh` verifies the authenticity of the remote host. If the remote host does
not successfully authenticate, the following message appears:

    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
    @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @ 
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
    IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY! 
    Someone could be eavesdropping on you right now (man-in-the-middle 
    attack)! 
    It is also possible that the RSA host key has just been changed. 
    The fingerprint for the RSA key sent by the remote host is 
    <key>.
    Please contact your system administrator. 
    Add correct host key in /home/user/.ssh/known_hosts to get rid of this 
    message. 
    Offending key in /home/ssh/.ssh/known_hosts:1 
    RSA host key for remote-sys has changed and you have requested strict
    checking. 
    Host key verification failed.

This message is caused by one of two possible situations. First, an attacker
may be attempting a man-in-the-middle attack. This is rare, since everybody
knows that `ssh` alerts the user to this. The more likely culprit is that the
remote system has been changed somehow, e.g. its operating system or SSH server
has been reinstalled. In the interests of security and safety, the first
possibility should not be dismissed out of hand. Always check with the
administrator of the remote system when this message occurs.

After it has been determined that the message is because of a benign cause, it
is safe to correct the problem on the client side. Remove the obsolete key from
the `~/.ssh/known_hosts` file. In the example message above, we see this:

    Offending key in /home/me/.ssh/known_hosts:1

This means that the first line of the `known_hosts` file contains the offending
key. Delete this line from the file, `ssh` will be able to accept new
authentication credentials from the remote system.
