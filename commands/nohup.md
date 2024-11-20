# `nohup`

[***Table of Contents***](/README.md)

It can be used to prevent the programs from receiving the "SIGHUP" signal:

```bash
man 7 signal
```

SIGHUP is the message that the OS can send to a process to indicate that the
opposite side of a conversation has hung up or end of the connection. The
phrase comes from from a time when most network communication took place over a
telephone modem where the phone could be physically hung up to end the call.

Imagine you have the following program that contains a busy loop that runs
forever:

```c
#include <stdio.h>

int main(){
    int i;
    while(1) { i++; }
    return 0;
}
```

If you compile and run it:

```bash
gcc main.c; ./a.out
```

And then close the terminal where it's running, the program will be terminated:

```bash
ps -ef | grep a.out # the program was automatically terminated
```

However, if you run the program with `nohup` and close the terminal, the
program won't stop running:

```bash
gcc main.c; nohup ./a.out
ps -ef | grep a.out # the program hasn't been terminated
```

Other factors, like custom signal handlers, can negate the effect of `nohup`. 

Many of these details are a part of a larger topic called "job control".
