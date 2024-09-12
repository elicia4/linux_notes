# The `dmesg` command

[***Table of Contents***](/README.md)

`dmesg` allows you to view the boot and live kernel messages.

These messages are recorded in *the kernel ring buffer*, the memory space where
kernel keeps its messages. `dmesg` is mostly used to print them out:

```bash
sudo dmesg 
```

Filter out the output with various utilities, e.g. `grep`:

```bash
sudo dmesg | grep "Bluetooth"
sudo dmesg | grep "boot"
# etc. etc.
```

You can follow the output (like `tail -f`):

```bash
sudo dmesg -w
```

Note that as the buffer grows the older messages are removed. They don't stay
forever. :)
