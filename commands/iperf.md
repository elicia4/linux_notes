# The `iperf` bandwidth tester

Notes taken on [this video](https://youtu.be/A-mDAB6jzbU) by Learn Linux TV
(Akamai Developer).

[***Table of Contents***](/README.md)

It's a great tool to test out bandwith to and from your servers.

Install `iperf` on both your client (local) and remote (server) machines:

    sudo apt install iperf # Debian-based
    pacman -S iperf # Arch-based
    # ...

Run `iperf` in server mode on your server:

    iperf -s 

You should get output similar to this:

    ------------------------------------------------------------
    Server listening on TCP port 5001
    TCP window size:  128 KByte (default)
    ------------------------------------------------------------

Run `iperf` in the client mode on your client and specify the server:

    iperf -c <server-ip>

You should now be connected. After about 10 seconds you get bandwidth
information on both your client and your server.

By default, the server launches in TCP mode. To launch it in the UDP mode:

    iperf -s -u

On the client, connect with the `-u` option:

    iperf -c <server-ip> -u

You can run `iperf` in bidirectional mode:

    iperf -c <server-ip> -d

You should now get output from both directions.

`iperf` is a great way to go any time you need to test out your bandwidth :)
