# Understanding Memory and Swap Usage

Notes on the video "Linux Crash Course - Understanding Memory and Swap Usage"
by LearnLinuxTV.

[***Table of Contents***](/README.md)  

A great utility for resource monitoring is `htop`. In case it's not available
and you can't install it, you need to use the widely available programs,
without installing any third-party utilities.

### Memory

To see how much memory you have available:

```bash
free -h # -h = human-readable
```

To see how much memory you have available in megabytes:

```bash
free -m
```
   
Focus on the `available` column, not `free`.

The `total` field shows the total amount of memory installed on the server. The
`used` field shows how much memory is currently being used. 

What's the difference between `free` and `available`? The `free` field shows
how much memory is currently absolutely free, all the memory is being used
except for the memory in the `free` field. 

Nowadays memory is thought of differently than is it used to be, *unused RAM is
wasted RAM*. Whatever is stored in memory can be retrieved faster than it can
be retrieved from the disk, you system caches as much as what makes sense to
cache, what you might need and what you might access, so that way all you need
can be retrieved a lot faster because it's sitting in RAM rather than being
pulled directly from the disk, thus also optimizing disk usage. 

So under the `available` field we have the amount of memory that is *actually*
available, it consists of data that is sitting in RAM, basically a cache that
is being used, but if you launch an app and it needs more memory, then the
system will give it some memory from `available`, it's only used when it's not
needed.

The `available` field is the total amount of memory that processes can get
access to if they need memory. `buff/cache` is the amount of memory being used
by the buffers and cache.

### Swap

`free` also shows the freely available swap. You want to use as little swap as
possible, because swap is a lot slower than RAM. Swap is emergency memory. In
Kubernetes, swap is not available. 

**The Out of Memory (OOM) Killer** may activate when memory is full to kill a
misbehaving process that's using the majority of your memory, but you don't
want to rely on that and instead ensure adequate swap in case memory is
exhausted.

Make sure you have swap on your Linux server, it might save you in emergency
cases, yes, it is slow, but it might save you. Also, some apps are *designed*
to use a little bit of swap. 

Swap can be a partition or a file. Swap in the file form is better since it
allows you to easily manipulate it. On Ubuntu, a swap file is used by default.

The swap file is declared in `/etc/fstab`. It's usually provided by default, it
case it's not (e.g., cloud providers), you create the file yourself and
activate it with:

```bash
sudo swapon -a
```

The command looks for the file in `fstab`, mount it, and activates it. To
deactivate:

```bash
sudo swapoff -a
```

If you don't have the file, create it:

```bash
sudo fallocate -l 16G /swapfile
```

It can be created anywhere, but `/swapfile` is optimal. `fallocate`
preallocates space to a file. Then you need to set its permissions:

```bash
sudo chmod 0600 /swapfile
```

Convert the file to the swap format:

```bash
sudo mkswap /swapfile
```

Lastly, mount it to `/etc/fstab`:

```bash
/swapfile   none   swap   sw   0 0
```

You can now activate it. Verify with `free`.

### Swappiness

How exactly does your system determine if it should use swap or not? Swappiness
is the variable that helps the system determine how frequently it should be
using `swap`. To see your swappiness value:

```bash
sysctl vm.swappiness
```

Or:

```bash
cat /proc/sys/vm/swappiness
```

Some admins change this value to optimize swap usage on their systems. There's 
no single value that works across the board, 60 is the default value on most
systems. The lower the swappiness, the less likely it is that swap is going to
be used. The value of 0 doesn't mean that swap will never be used, but it does
mean that your system will try its best to never use it.

To temporarily (and immediately) change the value:

```bash
sudo sysctl vm.swappiness=30
```

This value will change to the default one after reboot. To set the default
value:

```bash
sudo vim /etc/sysctl.conf
```

If the `vm.swappiness = <value>` line doesn't exist by default, add it
yourself.
