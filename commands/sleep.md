# `sleep`

[***Table of Contents***](/README.md)

It's used to delay for a specified amount of time:

```bash
sleep 123 # delay for 123 seconds
```

The commands above waits for 123 seconds doing nothing and returns control to
the prompt. Many version of `sleep` allow you to specify floating point
numbers:

```bash
sleep 2.3
sleep 0.4
```

Some versions of it allow you to specify a suffix after the number to control
whether the sleep time indicates seconds, minutes, hours or days:

```bash
sleep 2.3s # seconds
sleep 2.3m # minutes
sleep 2.3h # hours
sleep 2.3d # days
```

It's useful for scripting:

```bash
while true; do echo 'Hello World\!'; sleep 1; done
```

It lets you delay program execution without wasting CPU usage inside of a busy
loop.

If you run the following command in a busy loop it will also cause a delay,
just like `sleep` does, but it also consumes 100% of the CPU:

```bash
for i in {1..1000000}; do :; done
```

`sleep` allows for delays without wasting CPU by taking advantage of blocking
features within the OS's scheduler.
