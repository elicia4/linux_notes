SSH will only be able to work if there's a path between the client and the 
server. Every single node between them has to allow traffic, and if anything 
fails along the way your connection won't be established.

You have to have the openssh client installed on your computer. All modern Linux
distributions have ssh-client installed by default, MacOS also has it by default
and it's very easy to install on Windows.

Assuming your ISP doesn't have port 22 blocked, which very rare but it does 
happen you should have no trouble getting out of your LAN out to the Internet,
that's the easiest part. When you get to the remote server, the remote device
has to allow traffic on port 22. Most often it will accept all traffic. You have
to have 22 allowed straight through.

Most common errors you might get:

1) Invalid permissions. The .ssh directory should only be viewable, readable and
executable by YOU and no one else. The public keys inside should be readable by
everybody, the private keys only by YOU. If you set permissions to something
else, SSH will not work. If you cannot connect, check your permissions! You may
or may not get an error that permissions are the problem. 

When it comes to the remote end, you want to make sure the same thing.

2) Take a look at the log file:

    cd /var/log 
    tail -f auth.log 

You can have a user try to connect and look at the logs to find the issue.
Tailing is actually the old way of doing things, try using journalctl instead!
    
    journalctl -u sshd

You can also follow the log entries with the '-f' option:

    journalctl -fu sshd

This is the equivalent of 'tail -f' but with journalctl.
    
