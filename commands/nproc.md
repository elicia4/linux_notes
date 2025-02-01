# `nproc`

[***Table of Contents***](/README.md)

Shows how many processes your machine has:

```bash
nproc
```

Compare it with:

```bash
cat /proc/cpuinfo | grep 'model name'
```

^Shows the number of logical CPU cores on your PC. This is what `nproc` usually
indicates.

`nproc`'s return value can be influenced by two environment variables:
- OMP_NUM_THREADS
- OMP_THREAD_LIMIT


```bash
OMP_NUM_THREADS=999 nproc
OMP_THREAD_LIMIT=7 nproc
```

It can also be influences by the `--all` and `--ignore` flags:

```bash
OMP_THREAD_LIMIT=7 nproc --all
OMP_THREAD_LIMIT=7 nproc --all --ignore=5
```

`nproc` is not included in POSIX.

In the GNU core lib implementation of `nproc`, you can see that there are many
different system calls for many different platforms that `nproc` can run on.

Different software platforms or BIOS settings could affect the value returned
by `nproc`. Furthermore, concepts like hyper threading or power efficiency
features could further complicate the process of counting CPU cores.
