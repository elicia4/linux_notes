# Introduction and Unit Files

Notes on videos by tutorialLinux: https://youtu.be/N1vgvhiyq0E

[***go back to README***](../README.md)

- Intro

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
