# Understanding Memory and Swap Usage

Notes on the video "Linux Crash Course - Understanding Memory and Swap Usage"
by LearnLinuxTV.

[***Table of Contents***](/README.md)  

A great utility for resource monitoring is `htop`. In case it's not available
and you can't install it, you need to use the widely available programs,
without installing any third-party utilities.

### Memory

To see how much memory you have available:

    free -h # -h = human-readable

To see how much memory you have available in megabytes:

    free -m
   
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
system will give it some memory from the available field, it's only used when
it's not needed.

The `available` field is the total amount of memory that processes can get
access to if they need memory. There are also buffers, but you should look that
up yourself if you're interested.

### Swap

The `free` command also shows the freely available swap as you might have
already noticed. You want to use as little swap as possible, because swap is a 
lot slower than RAM. Swap is emergency memory. In Kubernetes, swap is not
available(?). 

MAKE SURE you have swap on your Linux server, it might save you in emergency
cases, yes, it IS slow, but it might save you.

Also, some apps are designed to use a little bit of swap. 

### Swappiness

How exactly does your system determine if it should use swap or not? Swappiness
is the variable that helps the system determine how much swap it should be
using at any given time. To see your swappiness value:

    sysctl vm.swappiness

Some admins change this value to optimize swap usage on their systems. There's 
no single value that works across the board, 60 is the default value on most
systems. The lower the swappiness, the less likely it is that swap is going to
be used. The value of 0 doesn't mean that swap will never be used, but it does
mean that your system will try its best to never use it.
