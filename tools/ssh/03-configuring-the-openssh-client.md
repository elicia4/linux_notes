# Configuring the OpenSSH Client

[***Table of Contents***](./README.md)  

Here's how to greatly simplify your connections in the future.

Create a `config` file inside your `.ssh` directory and add the following to
it:

```bash
vim config
```

```bash
Host ssh-server-name # server's name for ssh connections
  Hostname <IP> # the ip address of the host you connected to  
  Port 22 # it is default anyway  
  User <user> # user to connect with  
```

The SSH client will load this file to memory if it exists. And when it does,
it's going to have the entry for `ssh-server-name`. You could have called it
anything, it's completely up to you. Then you have the `Hostname` which is set
to the IP address of the server that you want that name to refer to. Port
`22` is the default, you didn't have to include this, however, there are cases
when SSH is configured to use a different port, and that's when it's useful.
You can now connect like so:

```bash
ssh myserver
```

You can include multiple servers in the `config` file! 

```bash
Host myserver # myserver is the host's name  
  Hostname <IP> # the ip address of the host you connected to  
  Port 22 # it is default anyway  
  User root # user to connect with  

Host server2
  Hostname <IP>
  Port 2222 # imagine it was reconfigured to this
  User serveradmin
```

Now you now don't need to remember the username, the hostname or the port for
either of the servers.

There are other things you can include in `config`, check out the
[online man
documentation](https://www.man7.org/linux/man-pages/man5/ssh_config.5.html) or
do it with `man`:

```bash
man 5 ssh_config
```

[***Next Note***](./04-using-public-private-keys.md)
