# Types of Virtualization

### Type 1 Hypervisors and Qubes

Type 1 hypervisors (T1HV) are usually installed on servers in racks you remote
into. You typically don't see them at desktops (with KVM, keyboard, video, and
mouse) at home. You usually work with headless machines here, you work with
everything over a terminal.

- A headless computer is a computer system or device that has been configured
to operate without a monitor, keyboard, and mouse.
    - A headless computer is a computer that has been configured to work
    without KVM.

An example of this would be data centers that let you rent a VPS. These run
some type of a T1HV (VMWare or Xen) on the physical hardware. The hardware is
usually a bucnh of multi-socketed motherboards filled out with Xeons or AMD
Epic CPU's, tons of RAM, tons of storage. Some of that hardware is then
reserved FOR YOU, depending on how much you pay for it. The more you pay, the
more you get. And then you can provision your VM there. 

For a web server, it doesn't matter if it runs on a virtual machine or directly
on hardware.

The hypervisor software for Data Centers is expensive, at least if you talk
about VMWare. But data centers can spend up to a million dollars to start a
company, so it's not that big of a deal for them.

QubesOS is another type of T1HV which has a different goal than VMWare.
Technically, Qubes is the OS, Xen is the T1HV. It's meant to run at home, it's
not meant to feel like a HV, it feels like a regular OS, except all of your
apps run in separate VMs. The reason for this is maximum security. It provides
a similar idea to Whonix. If you get viruses with Whonix, they likely won't
be able to compromise your system. The hacker might compromise the guest and
you can just delete that restart it, it's not a big deal.

If you were to run Whonix inside of KVM (Kernel-based Virtual Machine), it's
still not as secury as running it in a true T1HV. KVM is a virtualization
technology. Escaping a T1 is much more difficult than escaping a T2. KVM is
built as a kernel module into a Linux host. Qubes uses virtualization to keep
things separated, it's as secure as you can get as far as an OS goes, thanks to
the T1HV (as well as other great technology).

### Type 2 Hypervisors

The type of hypervisor you run on your host just like any other program.
Linux/MacOS/Windows, it doesn't matter. In this program, you run a virtual
machine with any other OS on it. VirtualBox is the most widespread solution,
another one is QEMU. The latter is better because it:

- supports more architectures, 
- is less laggy, 
- doesn't require a proprietary BIOS, 
- supports PCIe passthrough (graphics cards, sound cards, etc.).

When you do PCIe passthrough, you blacklist the PCIe device from your main
machine (you usually do this when you have multiple graphics cards for
example). It's really handy if you want to play Windows games on Linux, the
issues you may encounter (I have encountered *all of them*):

- anti-cheats not working on Linux (and therefore the game itself)
- problematic NVIDIA drivers
- issues with multiple graphics cards on your laptop
- compatibility layers impact performance

With PCIe passthrough, you can just create a Windows VM, pass through some RAM
and CPU, and then *directly* your graphics card.

### Containers

Run applications with all the environment requirements, without the need to
spin up an entire operating system (virtual machine). They're extremely
resource efficient. If you just need to set up a couple small web servers and
don't want to waste resources, this is solution will save you a lot. It adds
both security and convenience :).
