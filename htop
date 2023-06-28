###############################################################################
The 'htop' monitoring tool
Notes takes on this video by
LearnLinuxTV:
https://youtu.be/tU9cO9FwDx0
###############################################################################
htop is a system utility used for system resource monitoring. It's critical to
take care of your system's CPU and RAM usage.

'top' is a predecessor of htop. htop looks a lot better, is organized better 
and is available for most Linux systems. Note that top is still widely used.

htop outputs many important metrics, such as CPU usage, Memory usage, Swap 
usage, a list of processes running on the server and more.

You can customize the layout of htop as well. You can install 'htop' with your
package manager in case it's not installed, in case of Debian/Ubuntu:

	which htop # to see if it's installed 
OR
	command -v htop

In case it's not:

	sudo apt update # to update the repository index
	sudo apt install htop # to install

To run it:

	htop

You can use your MOUSE inside htop, try sorting something by clicking on a
column. By sorting MEM% or CPU% you can narrow down which processes are using
most of the memory or CPU resources. 

At the top you have several different meters, one for each CPU core, you can
also add an Avg CPU bar, which is not present by default. There is also Mem, or
memory to see how much memory is being used, Swp for swap.

Use up and down arrows to navigate through the list of processes. You can kill
a process with F9 and then selecting a signal to send to the process, in case
of a process that's misbehaving its a good idea to send SIGTERM first, which
asks the process to close down by itself cleanly, but if it's not working you
should send SIGKILL. You can navigate thse signals with with numbers as well as
arrows. You should use SIGKILL as a last resort. On a production server, be
especially careful with this.

To sort by CPU usage, press Shift + p. 
To sort by Memory usage, press Shift + m. 

You can customize htop by pressing F2 (take a look at the bottom bar, it shows
you what all the 'F' keys do). Take a look at Categories on the left, the 
customization interface is pretty intuitive and self-explanatory. You can 
customize the top section of htop in the meters section. Use the arrow keys to
navigate. Don't forget about the line at the bottom.

To look for specific processes:

Press 'u' for user, a list of users will be shown on the left, you can navigate
it by typing in the needed username or using the arrows.

You can find a specific process by pressing F3 (or '/') and typing in the name
of the process. 
