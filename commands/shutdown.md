# Commands to Shutdown and Reboot on Linux

Notes taken on this video by DistroTube: https://youtu.be/BdRIhFcf4Do

[***Table of Contents***](/README.md)

The majority of distributions use `systemd`. You can reboot a machine using
`systemd`:

```bash
sudo systemctl start reboot.target
```

OR:

```bash
sudo systemctl start reboot
```

OR: 

```bash
sudo systemctl reboot
```

OR:

```bash
sudo reboot
```

`systemd` made it so convenient these days on `systemd` distros that you don't
even need `sudo` privileges anymore:

```bash
reboot
```

The same applies to `shutdown` and `halt`:

```bash
shutdown
halt
```

`halt` is used to instruct the hardware to stop all the CPU functions.

You can reboot with the `-r` flag:

```bash
sudo shutdown -r <delay>
```

`<delay>` is pretty self-explanatory, it can be a number, `now` for immediate
action. 

You can also halt the machine using the `-H` option:

```bash
sudo shutdown -H now  
```

To specify a time:

```bash
sudo shutdown 22:30
```

To cancel a shutdown:

```bash
sudo shutdown -c 
```

`reboot` also has some flags. You can shutdown with `-p` to power off:

```bash
sudo reboot -p 
```

There is also a force `-f` flag:

```bash
sudo reboot -f 
```

Non-systemd distos have similiar functionality. To reboot:

```bash
sudo init 6
```

`6` is the run-level number. `0` is used for shutdown:

```bash
sudo init 0
```

If you work with a remote machine and you have to shutdown or reboot it, you
can use a "Sys Rq" key. If you have a full keyboard, you should have it, it's
likely called "Prt Sc" or "Prt Sc / Sys Rq". 

What you have to do is hold "Alt + Sys Rq" and then give it a sequence of keys
to force either a reboot or a shutdown. If you have privileges to do so, it's 
going to work. To see:

```bash
cat /proc/sys/kernel/sysrq
```

You want `1`, it gives you all privileges with the "Sys Rq" commands. `0` means
no privileges. To change that:

```bash
echo "1" | sudo tee /proc/sys/kernel/sysrq
```

Now you have privileges to use "Sys Rq". Hold "Alt + Sys Rq", and then hit the
following sequence of characters for **reboot**.

```bash
r # switches your keyboard to xlate mode
e # sends a SIGTERM signal to all running proccesses EXCEPT init
i # sends a SIGKILL signal to all proccesses
s # syncs all your mounted file systems
u # remounts all mounted file systems as read-only
b # reboot 
```
    
You can use `o` instead of `b` at the end to shutdown. 

The Sys Rq method is the **NUCLEAR** option. 
