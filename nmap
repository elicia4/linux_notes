###############################################################################
The 'nmap' command
Notes takes on this video by
LearnLinuxTV:
https://youtu.be/5tzp9QzwnUQ
###############################################################################
'nmap' allows you to do network auditing, find out which hosts are up, which
ports are open, and so on. 

WARNING: Using 'nmap' on networks that are not yours may not be safe, ask for
permission before using it or you might get into trouble :)

On Ubuntu/Debian you can install it with:
	
	sudo apt install nmap

Or on Arch-based distros with:

	pacman -S nmap

Refer to your OS's documentation to find out how to install nmap.
To confirm that you have nmap:

	nmap -v 

To scan a node:

	nmap <IP-address>

You can also scan a hostname or a domain name:

	nmap <random.domain.name>

To activate verbose mode use the '-v' option, it will show some additional
information:

	nmap -v <destination>

To scan multiple IP addresses:

	nmap <IP-1> <IP-2> <...>

To scan a range of IPs:

	nmap X.X.X.2-6

^This will scan all IP's that end with 2 through 6.

You can also exclude a host from a scan:

	nmap X.X.X.2-6 --exclude X.X.X.4

To scan and find out service/port version information:

	nmap -sV X.X.X.X

You can detect an operating system with the -A option:

	nmap -A X.X.X.X

To scan a subnet:

	nmap <IP>/<CIDR>

E.g.:

	nmap X.X.X.X/24

To do a subnet scan and have a more condensed and readable output:

	nmap -sP <IP>/<CIDR>

^This is useful for auditing in cases when you have to know which hosts are up
in the first place.

You can time any command in Linux with time:

	time <command>

You can speed up nmap with the -T option:

	nmap -T5 <...>

-T<0-5> tells nmap to use a different timing template. There are 6 of those in
nmap, 0-5. T5 is the fastet mode available, though some accuracy might be lost.
With this option nmap also assumes that your network is fast enough to handle
this mode, but modern networks should never have any problem with this.
T0-2 are slower, but they are useful to find out if one can bypass an
intrusion detection system (IDS) if there is one. Slower modes tend to fly 
under the radar. T3 is default. T4-T5 are faster, but as mentioned before
accuracy is lost.
