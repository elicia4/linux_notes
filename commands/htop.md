# `htop`

Notes taken on [this video](https://youtu.be/tU9cO9FwDx0) and documentation.

[***Table of Contents***](/README.md)  

`htop` is a system resource monitoring utility. 

`top` is a predecessor of `htop`. `htop` looks a lot better, is organized
better and is available on most Linux systems. `top` is still widely used.

`htop` outputs many important metrics, such as CPU usage, Memory usage, Swap 
usage, a list of processes running on the server and more.

You can customize the layout of `htop` as well. See if it is installed:

```bash
which htop # to see if it's installed 
command -v htop
```

On Debian/Ubuntu, install it with:

```bash
sudo apt update # to update the repository index
sudo apt install htop # to install
```

Run it:

```bash
htop
```

You can use your mouse inside `htop`, try sorting something by clicking on a
column. By sorting `MEM%` or `CPU%` you can narrow down which processes are
using most of the memory or CPU resources. 

At the top you have several different meters: 

- one for each CPU core, you can also add a `CPU Average` bar, which is not
present by default;
- load averages;
- uptime;
- number of tasks;
- `Mem`, or memory to see how much memory is being used;
- `Swp` for swap.

In the lower section a list of processes with various fields is shown:

- Process ID (PID)
- the user running it 
- CPU usage
- memory usage 
- the command 

Hotkeys:

- **up**/**down**, **PgUp**/**PgDn** to navigate through the list of processes
- **F9** to send a signal to the selected process 
- **Shift + p** to sort by CPU usage 
- **Shift + m** to sort by Memory usage
- **u** to sort by user, a list of users will be shown on the left, you can
navigate it by typing in the needed username or using the arrows
- **F3** or **/** to find a specific process, type in the name
- **F5** to switch between list and tree views
- **F2** to customize (F-keys functions are shown at the bottom)

In case of a process that's misbehaving its a good idea to send **SIGTERM**
first, which asks the process to close down by itself cleanly, but if it's not
working you can send **SIGKILL**. You should use **SIGKILL** as a last resort.
On a production server, be especially careful with this. *You can navigate
these signals with numbers as well as arrows.* 

While customizing, take a look at **Categories** on the left, the customization
interface is pretty intuitive and self-explanatory. You can customize the top
section of `htop` in the meters section. Don't forget about the line at the
bottom.

You can change the speed at which it updates, measured in 1/10 of a second:

```bash
htop -d 50 # refreshes every 5 seconds
```
