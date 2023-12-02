# Package Management

[***go back to README***](/README.md)  

*Package management* is a method for installing, removing, upgrading, and
configuring software. *A package manager* (a package-management system or a
packaging system) is software that does package management, it deals with
*packages*. 

*A package* (package file) is an archive file that contains programs, data
files, additional information (metadata) needed by its package manager, and
installation scripts. Packages are mantained by *package mantainers*. The
package mantainer gets the source code from the author of the software (*the
upstream provider*), builds it, creates the package metadata and any necessary
installation scripts. Often distrubution-specific additions are made to
software to improve its integration with other parts of the system.

Different distros use different package managers, a package intended for one
distribution is usually not compatible with another distribution. The two most
popular packaging technologies are Debian (`.deb`) and Red Hat (`.rpm`), *there
are many others.* 

Some of the distributions that use the Debian (`.deb`) packaging system are:
- Debian
- Ubuntu
- Pop!\_OS
- Kali Linux
- MX Linux
- Linux Mint

Some of the distributions that use the Red Hat (`.rpm`) packaging system are:
- Fedora
- CentOS
- Red Hat Enterprise Linux (or RHEL)
- Rocky 
- OpenSUSE

Packages are usually created and mantained by distribution vendors and
interested third parties, though some software packaging and distrubtion is
performed by the software creators themselves. Packages are made available in
*repositories* (or repos), they may contains thousands of packages, each one
made specifically for the distribtuion.

Distribtuions may have different repositories for different levels of the
software development cycle. A *testing* repository contains recently built
barely tested packages that may contain lots of bugs. A *development* repo
stores work-in-progress packages destined for release in the distrubtion's next
major update. Third-party repositories also exist, to use them one must include
them in the configurations manually.

Packages are often dependant on other packages to work, those packages are
called *dependancies*. For example, IO routines are stored in *shared
libraries*, which provide their services to many programs. To ensure all of the
dependancies are installed during a package installation, most modern package
managers provide *dependancy resolution*.

Low-level package tools can usually do basic things, such as installing and
removing packages, while high-level package tools have some additional
functionality like dependancy resolution and metadata searching.

Debian's low-level tool is `dkpg`, high level tools are `apt`, `apt-get`, and
`aptitude.` RedHat's low low-level tool is `rpm`, high level tools are `yum`
and `dnf`.

To find a package:

    # Debian
    apt-get update # do this when working with a repository
    apt-cache search <package>

    # RedHat
    yum search <package>

To install a package:

    # Debian
    apt-get install <package>

    # Red Hat
    yum install <package>

To install a package from a local package file:

    # Debian 
    dpkg -i <package>

    # Red Hat
    rpm -i <package> # note that this doesn't do dependancy resolution

To remove a package:

    # Debian
    apt-get remove <package>

    # Red Hat
    yum erase <package> 

To update all the packages:

    # Debian
    apt-get update; apt-get upgrade

    # Red Hat
    yum update

To upgrade a package from a package file:

    # Debian
    dpkg -i <package> # same thing as installing one

    # Red Hat
    rpm -U <package>

To list installed packages:

    # Debian
    dpkg -l

    # Red Hat
    rpm -qa

To determine whether a package is installed:

    # Debian
    dpkg -s <package>

    # Red Hat
    rpm -q <package

To display information about an installed package:

    # Debian
    apt-cache show <package>

    # Red Hat
    yum info <package>

To determine what package is responsible for the installation of a file:

    # Debian
    dpkg -S <file>

    # Red Hat
    rpm -qf <file>
