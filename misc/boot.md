# The Linux Boot Process

Notes on [this video](https://www.youtube.com/watch?v=XpFsMB6FoOs) and
documentation.

### BIOS/UEFI

The process starts when you power on your computer. First, a BIOS/UEFI program
boots up, this software gets your hardware ready

UEFI is the newer version of BIOS offering features like secure boot, faster
boot times etc.

One key difference is their approach to disk storage:

- BIOS
    - is tied to Master Boot Record (MBR), which limits disk size to 2TB
    - slower boot time
    - less secure boot
- UEFI
    - uses GUID Partition Table (GPT), removing these size restrictions
    - faster boot time
    - secure boot

BIOS/UEFI runs POST (power-on self-test), it checks hardware before proceeding
to the next step:

- processors
- memory
- storage
- controllers
- keyboard
- pointer device
- system timer

The exact list of hardware checked depends on your system. If POST finds a
problem, you will likely see a message on your screen or hear coded beeps.
These beeps have meaning, refer to the hardware/firmware documentation. A POST
error is usually fatal and halts the boot process. If everything checks out,
BIOS/UEFI will try to find the boot loader software.

BIOS/UEFI looks for the boot loader according to the boot order. The boot order
is usually:

1. HDD/SSD
1. USB/CD

The boot order can be changed in the BIOS/UEFI settings.

### The Boot Loader

On a BIOS system, the boot loader lives in the first chunk of storage called
the Master Boot Record (MBR).

For UEFI, there's a separate partition that stores files like the `.efi` boot
loader file.

Default UEFI disk partitions:

- Disk 0
    - EFI system partition (100M, System) - `.efi` boot loader is here
    - MSR (128M, MSR)
    - Primary partition (Linux)

The key jobs for the boot loader are:

1. Locate the OS kernel
1. Load the kernel into memory
1. Start running the kernel code

Some boot loader you might see are GRUB2 and LILO, the latter being very rare
these days. GRUB2 is full of features and widely used today.

Once the boot loader loads up, it inserts the kernel into memory and hands over
the control to the kernel to finish the process. 

The kernel takes over the computer's resources and starts up all the background
processes and services. It decompresses itself into memory, checks the hardware
again and loads drivers and other kernel modules.

### The `systemd` Init Process 

Next, the init process, the init system is launched, usually Systemd. Systemd
replaced older init systems, such as SysVinit and Upstart. It's the parent
process of all other processes on Linux.

Systemd utilities:

- systemctl
- journalctl
- notify
- analyze
- cgls
- cgtop
- loginctl
- nspawn

Systemd daemons:

- systemd
- journalctl
- networkd
- loginduser
- session

Systemd targets:

- bootmode
- basic
- shutdown
- reboot
- multi-user
    - dbus
    - telephony
    - dlog
    - logind
- graphical
    - user-session
        - display service
        - tizen service

Systemd has a ton of responsibilities to get the system booted and ready to
use. It checks for any remaining hardware that needs its drivers loaded, it
mounts up all your different file systems, it launches all the background
services like networking, sound, power management, handles user logins, loads
up your desktop environment.

Systemd uses target config files to decide which mode it should be booting into
\- something basic like multi-user text-only target, or the graphical target
mostly used daily. There's also a `sysinit` target. These target correspond to
older run levels.

Systemd handles initializing everything that needs to launch when starting up
Linux.
