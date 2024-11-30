# `stdbuf`

[***Table of Contents***](/README.md)

It can be used to change the buffering behavior of STDIN and STDOUT:

```bash
stdbuf -o0 your-command
```

Imagine you have the following C program that prints out a message:

```c
#include <unistd.h>
#include <stdio.h>

int main() {
  while(1) {
    printf(
      "\033[93mURGENT WARNING\033[0m: "
      "'\033[31;4mEVERYTHING IS FINE!!!\033[0m'\033[B\r"
    );
    usleep(500000);
  }
}
```

If you compile and run it, you won't see any output:

```bash
gcc calm-down.c -o calm-down; ./calm-down
./calm-down | xxd # not even with `xxd`
```

It's because by default many programs that output to an interactive terminal
use line-based output buffering. Since the text that's printed by the program
above doesn't contain any newlines, the output simply accumulates in the
buffer. 

You can use `stdbuf` to run your program with line-based output buffering
switched off:

```bash
stdbuf -o0 ./calm-down
```

Now you can see the messages!

It includes even more buffering options for input and error streams:

```bash
man stdbuf
```
