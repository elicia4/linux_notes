# The `top` command

Notes taken on the "Demystifying the Top Command in Linux | Linux Crash Course
Series" video by LearnLinuxTV.

[***go back to README***](/README.md)

It's installed by default on most Linux distributions. It's a monitoring
utility, you can see what processes are running, how many resources (CPU and
memory) are used and so on.

Basic usage:

    top

The output is updates every 3 seconds by default. Every time it updates, it
shows the current snapshot of the resource usage on your system. If you're
experiencing a resource contention, the `top` command is a great place to
start. Press `q` to quit.

`top` is split into 2 main sections. You have statistics at the top and the
process table at the bottom. 

### The statistics section 

Let's go over the top section first. The first line is filled with uptime, the
number of logged in users and load averages. A small uptime is potentially a
problem, it might be okay if you have something like automatic updates
installed, but if you didn't plan for a restart of the system and it shows a
low uptime, you should look into it. 

The second line gives you statistics around tasks that your computer or server
is running. Running tasks does not equal the number of applications you have
opened. Running tasks are the tasks that utilize the CPU at the moment, apps
only utilize the CPU when they need something. A task that is stopped is in the
process of closing down. 

What is a zombie process? A child process is one that was started by another
process, you can see them by pressing `<Shift + V>`. You can see a relationship
between child and parent processes now. At the top on the right, you can
probably see `systemd`, it makes sense since it's an init system, it's the
first process that runs and it schedules the other processes. Virtually
everything is the child process of `systemd`. But it's not the only process
that can spawn other processes. But what does it have to do with zombie
processes? When a child process is closed, it waits for final instructions from
its parent in order to free up resources, so what happens is when a child
process gets finished it becomes a zombie, it waits for its parent to release
it and remove it from the system. However, if a parent process is closed and
the child process is still running and it is waiting for instructions from a
process that no longer exists, then it can become an orphan. It will stay
running forever because there's nothing to give it final instructions, it's
never going to happen. Mostly, zombie processes don't take up much resources on
the system and are not a cause for alarm. A simple solution is to reboot the
system, that will clean all processes.

The third line has to do with statistics that pertain to your CPU. `us` means
user space, `sy` refers to kernel space (`sy` means system but it's about the
kernel), they are directly related to each other. User space is where programs
run, anything that is not directly tied to the kernel is running in user space.
The percentage that you see is the percentage of time your CPU has been used to
process tasks within that category. `ni` stands for niceness, it refers to
priority or the nice value of a process. You can configure the niceness value
of a process to alter its scheduling priority on the CPU. You might be running
something on your machine that is super important and you want to make sure
that the CPU is paying special attention to that process, in that case you
might want to configure the niceness value of that process to increase its
priority. In regards to `top`, the field shows the percentage of time the CPU
has spent running processes that were configured with a custom niceness value.

`id` is for "idle". It shows how much time the CPU has been idle for, the
higher the number, the less busy the system generally is.

`wa` stands for "waiting", how long has a task has been waiting for input or
output. The higher the wait percentage, the worse it is, we don't really want
your servers to be waiting on anything, the lower the better.

`hi` and `si` refer to hardware and software interrupts respectfully, how much
time the CPU is spending processing hardware and software interrupts. It's not
a big issue these days.

`st` refers to how much time the virtual CPU has been waiting for the physical
CPU.

The fourth line contains memory information, it's pretty straightforward. The
final field shows how much memory the cache is using, this is information that
exists on the storage medium that is loaded into memory or is in the process of
being written to the disk. Linux tries to be as efficient as possible with
this. Normally, you won't have to intervene when it comes to the cache. You
should keep in mind that when your system starts to run low on memory, the
memory from the cache will be made available to processes as needed, it's not
locked. Unused memory is wasted memory.

The last line is all about swap. It's memory that is located on your hard
drive, it's a lot slower when compared to RAM. The less swap used, the better.

### The Process Table

You can see the process ID (`PID`), the user that's running the process
(`USER`), the niceness value or the priorty of the task (`NI`), the total
amount of virtual memory being used (`VIRT`) by that task, how much physical
memory is used (`RES`), `SHR` refers to the amount of shared memory that is 
begin used by a task. Then we have percentages for both memory and CPU (`%CPU`
and `%MEM`). The `TIME+` field tells us how much time the CPU has spent on that
particular task. At last, we have the command itself (`COMMAND`).

You will pay much attention to the CPU and memory usage. To sort the processes
by CPU usage press, `P`. To sort by memory usage, press `M`. What do you do if
a process is taking up too many resources or is frozen? Press `k` on your
keyboard, that will bring up the `PID to signal/kill` and enter the PID of the
process that's causing you trouble (press `Esc` to get out of the prompt). You
should always try to kill a process normally without resorting to that, but if
you can't this is a solution. To change the update frequency of `top`, press
`d`. You get `Change delay from 3.0 to`, enter your desired delay. 

### Most important things

Focus on these fields, they are important.

- Uptime
- Load average
- The idle field `id`, and underused/overused server can be a problem, the
  server exists to do work
- Swap shouldn't be overly utilized, if it is, something is saturating the
  memory
- Memory

### Misc

`htop` is also a great monitoring solution, but it's not as widely available by
default as `top`.

`top` is also customizable, see the man pages:

    man top
