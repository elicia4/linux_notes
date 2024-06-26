# The `ping` command

Notes taken on the "Linux Crash Course - The ping Command" video by
LearnLinuxTV.

[***Table of Contents***](/README.md)  

The `ping` command helps you to determine whether a server is online, if it's
online it will reply to your ping. It works by sending "ICMP ECHO_REQUEST"
messages to a host. Hosts will reply with "ICMP ECHO_REPLY" messages, thus
verifying that the pinged host is active and the connection was successful.

The basic usage of ping is:

```bash
# ping <IP-address/domain-name>
ping 8.8.8.8 # google DNS
```

The ping is endless by default, sending pings every second, cancel it with
`<CTRL-c>` whenever you feel like it. To ping a domain:

```bash
ping learnlinux.tv
```

The type of network traffic used with the ping command is ICMP (Internet
Control Message Protocol), that's the protocol that ping uses when it goes to
reach a server. When you ping, your PC sends an ICMP echo request and gets back
ICMP echo reply. This is important because it can be useful when blocking 
traffic with a firewall. 

The Windows version of ping pings 4 times and then stops. To send a specific
number of pings on Linux use `-c`(=count):

```bash
ping -c 5 learnlinux.tv
```

At the end of each line, you see the amount of time it took to get back a
reply. At the bottom, you see the percentage of packet loss, obviously 0% is
ideal. 

Ping is something that we can use as the first level when we're troubleshooting
something. Depending on the results you decide what tools to use next.

Sometimes we use ping to determine if we have an Internet connection:

```bash
ping -c 5 8.8.8.8
```

If you can't ping this IP address, the problem is likely on your side. Try
taking a look at your DHCP and DNS settings. 

You can also determine when a server has come back online with `ping` (after
reboot for instance), this is certainly better than using the `ssh` command
over and over again:

```bash
ping <server>
```

Reboot it while it's pinging, when you start getting replies again the server
is back online.
