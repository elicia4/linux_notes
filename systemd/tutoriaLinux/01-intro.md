# Introduction and Unit Files

Notes on videos by tutorialLinux: https://youtu.be/N1vgvhiyq0E

[***go back to README***](../README.md)

**Table of contents**
- Intro
- [`systemctl` commands](./02-systemctl.md)
- [Targets](./03-targets.md)
- [Dependencies & Ordering](./04-dependencies.md)
- [Timers](./05-timers.md)

### In this note

- What is init in Linux?
- General systemd theory
- Units
- Unit files

"init" is a process that is started by the kernel. It is special because it is
the first process that is started during boot, its process ID (PID) is 1. This
process is responsible for booting the rest of the system. It's a long running
process that has some power over other processes. 

For instance, if a process is orphaned (its parent process dies), it is
reparented under init. It takes care of orphans, it takes care of zombie
processes, it's responsible for process stuff that can go wrong during the
operation of the system. systemd is init, but it also handles all system state
and service stuff during boot and during the time that that system is up and
running. 

systemd is a collection of programs and libraries:

- systemctl
- journalctl
- Init
- Process management
- Network management (networkd)
- Login management (logind)
- Logs (journald)
- and so on...

A systemd unit is any entity that is managed by systemd. It can manage a:

- Service
- Socket
- Device
- Mountpoint / Automount point
- Swap file
- Partition
- Startup target (akin to named runlevels)
- Watched filesystem path
- Group of externally created processes

### Unit file locations

- /lib/systemd/system - standard systemd unit files (your distro maintainers)
- /usr/lib/systemd/system - from locally installed packages (e.g. via apt-get)
- /run/systemd/system - transient unit files
- **/etc/systemd/system** - this is where you're putting your custom unit files.

### Minimal Unit file Example 

Create and edit it:

    vim /etc/systemd/system/yourservice.service

Fill it in like so:

    ```
    [Unit]
    Description=A very simple service created by Me
    # After the network service is up
    After=network-up.target

    [Service]
    ExecStart=/usr/local/bin/yourprogram

    [Install]
    # This service is used by multiple users
    WantedBy=multi-user.target
    ```

Check if the service exists:

    systemctl status yourservice

If it doesn't, do `daemon-reload`:

    systemctl daemon-reload

It makes systemd reread all init files.

Let's inspect a more advanced unit file:

    systemctl status nginx

Take a look at the `Loaded:` line, there is a path to the unit file. This is the
easiest way to find it.

In the `[Unit]` section, the `After` parameter defines what service should be
already running before this service starts.

Under the `[Service]` tab, the `Type` proccess defines what type of process it's
going to be, how it will be managed. For instance, `forking` means that the
process you start isn't going to be around, even though `nginx` will still be
up, so don't expect the main process to stick around. How does systemd know that
the process ran? The `PIDFile` parameter is the name of a file that `nginx`
should create after it ran. 

You can execute things before the process starts: `ExecStartPre`. `ExecStart` is
the command for actually starting the service. `ExecReload` and `ExecStop` run
after the `systemctl reload` or `systemctl stop` commands are issued. 

The `[Install]` sections tells us at what point should this unit be running.
