# What is a Linux Distribution?

Notes taken on the "Linux Crash Course - What is a "Distribution" of Linux?"
video by Learn Linux TV.

[***go back to README***](/README.md)

### What is a "Distribution" of Linux?

- Linux is a kernel, not an OS
- A kernel is the brain of an OS, it handles I/O, interfaces, hardware etc.
  It's the most important part of an OS
- Regardless of an OS you're using, there's a kernel
- A "distribution" of Linux is a combination of the Linux kernel and additional
  software
- Desktop environments provide "desktop-like" features
- Not all distributions are meant for desktop and laptops
- "Server" distributions often don't feature a GUI by default

By itself, it's not enough to give you the functionality that you would expect
from an OS; it doesn't provide you with a GUI, a web browser and all the things
you are used to seeing, but it does contain the critical interfaces that such
things need in order to run it all.

A desktop Linux distro would include a Desktop Environment (DE), there are many
of them. It provides you with a GUI to interact with your computer.

Distro = Distribution. Not all distros provide a DE, for example server
distros. A DE is a waste of resources when it comes to servers.

### Why are there so many distros?

- [Distrowatch](https://distrowatch.com/) is a website that lists quite a few
  of the distributions that are available
- Although it's a useful site, it's NOT an accurate portrayal of actual
  popularity of market share. It's still a good way to see what distributions
  are available
- The number of distributions can be overwhelming

Some Linux distributions are not aimed to be Desktop distributions, for example
CloneZilla is a distro used to clone hard drives. Each desktop distro features
a unique combination of software, to target a specific audience. More distros =
more choice. There are also "advanced" distros for people who want more
control.

### Ubuntu

New versions of Ubuntu release every 6 months. It's a GNOME distro, it's a
highly customized version of GNOME, there are some performance tweaks too. Some
default apps it includes:

- Firefox - Web browser
- Thunderbird - Mail client
- LibreOffice - Office suite
- Terminal 
- Shotwell - Photos
- Cheese - Webcam app
- ...and so on

The "Additional Drivers" app is great for driver installation. Drivers get
updated regularly, in case you get the newest hardware at some point, the
drivers for it will likely be available. 

There are other versions of Ubuntu that provide a different DE, like Xubuntu,
Kubuntu etc. 

LTS (long-term support) releases are supported (receive security updates) up to
five years.  
Interim releases only have 9 months of support.

Ubuntu is based on Debian. It is a great beginner distro.

### Fedora

Fedora is also a GNOME distribution. It's a vanilla GNOME version.

- Firefox - Web browser
- LibreOffice - Office suite
- GNOME Boxes - Virtual machine app

Fedora releases roughly every 6 months. Fedora is very stable.

### Debian

It's one of the most influential distributions of Linux, many of them (like
Ubuntu) are based on Debian. There are 3 versions:

- Stable - solid, tested, doesn't change much
- Testing
- Unstable

Stable doesn't get new software, but gets security updates. Feature updates are
not available. If you want a distro that is more up-to-date, consider "Testing"
or "Unstable". 

The way packages work is they get released on Unstable, then go to Testing and
finally to Stable.

The main downside of Debian Stable is that you're going to be on pretty old
versions of everything, that's why many people run Debian Testing. 

There is no release schedule. 

If you don't care about bleeding edge software, Debian might be a great choice
for you. Debian Stable is stable in every sense of the word.

- Firefox - Web browser
- LibreOffice - Office suite, be careful with it on Debian, it's very old.
  Every version of LibreOffice that gets released has better support for
  Microsoft Office. You will run into compatibility issues.
- Thunderbird - Email

### openSUSE

There are 2 types of releases:
- Leap - general purpose distro
- Tumbleweed - rolling version, install once and update forever.

You get a choice of desktop environment at the beginning. The Plasma DE is
considered to be default. 

- Firefox - Web browser
- Dolphin - File manager
- LibreOffice - Office suite
- Kate - Text editor
- VLC - Video player 
- KMail - Email

YaST is a control center on steroids. There's a command line version of YaST as
well. It gives you a lot of power. It has built-in "Windows Domain Membership",
if you're working in an enterprise environment, this might come in handy for
you, in case you're required to join everything to a domain.

At its core, openSUSE is an enterprise Linux distribution. There's also SUSE 
enterprise Linux, a distribution for companies. Both of these distros share the
same base. Even though you're using a desktop version of openSUSE, you have an 
enterprise Linux core that makes your system more stable.

This distro is incredibly stable.

### Pop!\_OS

It is technically it's a GNOME distro. The implementation of GNOME in Pop!\_OS
is known as the Cosmic desktop, many changes to GNOME have been made. 

There's a search box you can open by clicking on the leftmost icon on the
bottom panel or by pressing the Super key.

Pop!\_OS is a great distro, it's based on Ubuntu. It's great for gaming, for
drivers, for upgrading and recovery. It has a dedicated NVIDIA distro.
