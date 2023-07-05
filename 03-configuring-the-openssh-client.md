Here's how to greatly simplify your connections in the future.

Create a 'config' file inside your .ssh directory:

    touch config

Edit it!

    vim config

##############
Host myserver # myserver is the host's name
  Hostname <IP> # the ip address of the host you connected to
  Port 22 # it is default anyway
  User root # user to connect with
##############

The SSH client will load this file to memory if it exists. And when it does,
it's going to have the entry for myserver. You could have called it anything, it
doesn't have to match anything, it's completely up to you. Then you have the 
hostname which is set to the IP address of the server that you want that name to
refer to. Port 22 is the default, you didn't have to include this, however,
there are cases when SSH is configured to use a different port, and that's when 
it's useful. You can now connect to your server with the same account with a 
shorter command:

    ssh myserver

You can include multiple servers in the config file! 

##############
Host myserver # myserver is the host's name
  Hostname <IP> # the ip address of the host you connected to
  Port 22 # it is default anyway
  User root # user to connect with

Host server2
  Hostname <IP>
  Port 2222 # imagine it was reconfigured to this
  User serveradmin
##############

Now you have 2 servers in the SSH config file! You now don't need to remember
the username, the hostname or the port for either of these servers, you have 
simplified it quite a bit. And that is the benefit of your config file. 

There are other things you can include in the config file.
