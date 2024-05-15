# Building and Installing Software Packages

[***Table of Contents***](./ToC.md)

Based on the [***Ancient (1999) Mendel Cooper's
Guide***](https://tldp.org/HOWTO/Software-Building-HOWTO.html#toc4).
Information in this guide may be *significantly* out of date, I tried to get rid
of unnecessary information, but I'm unsure if I deleted all of it due to my
inexperience with software building.

### Intro

Many software packages come as compressed archives of source files. The same
package may be "built" to run on different target machines, and this saves the
author of the software from having to produce multiple versions. This puts the
responsibility of "building" and installing the software on the end user. 

### Unpacking the Files

Once you get a software package, it's likely archived (*tarred*) and compressed
(*gzipped*), in `.tar.gz` or `.tgz` form (known as *tarball*).

1. Copy it to a working directory
1. *Untar* and *gunzip* it

```bash
tar xzvf <filename>
# equivalent to 
# gzip -cd filename | tar xvf -
# gunzip -c filename | tar xvf -
# `-` causes tar to take input from stdin.]
```

1. You may preview this process without unpacking:

```bash
tar tzvf
```

1. To untar a bzip2 file (`.tar.bz2`):

```bash
tar xjvf
```

Sometimes the archived files need to be extracted in specific locations, so if
you get error messages while untarring, this might be the reason. Read the
package docs (especially `README` and `INSTALL`) and edit the config file
and/or `Makefiles` as required. You would *not* ordinarily edit the `Imake`
file since that might have unforeseen consequences. Most packages automate this
process by running `make install` to place the binaries in appropriate places.

If you encounter a `shar` file (*shell archive*), to unpack:

```bash
unshar filename.shar
```

Most of the other compression utilities (`zip`, `rar`, etc.) have software to
unpack them on Linux as well.

Occasionally, you may need to update unarchived source files using a `patch` or
`diff` file. The doc files and/or `README` will inform you should this be the
case. To use `patch`:

```bash
patch < patchfile
```

### Using Make

A Makefile is a script generally used for compiling the binaries, though it has
many other uses (like updating a package without having to recompile every
source file in it).

Makefile launches `cc` or `gcc` at some point: a preprocessor, a C (C++)
compiler, and a linker, invoked in that order. This process converts the source
into the binaries.

To build all the necessary binaries:

```bash
make
```

To install the files in their proper directories:

```bash
make install
```

To remove stale object files:

```bash
make clean
```

To preview the build process without actually executing them:

```bash
make -n
```

Only the simplest software uses a generic Makefile, more complex installations
require editing the Makefile according to the location of libraries, include
files, etc. `Imake` and `xmkmf` accomplish this task.

An Imakefile is a "template" Makefile. `imake` constructs a Makefile from the
Imakefile. In almost all cases, however, you would run `xmkmf,` a shell script
that invokes `imake`, a front end for it. Check `README` or `INSTALL` for
specific instructions. If, after dearchiving the source files, there is an
Imake file present in the base directory, this is a dead giveaway that `xmkmf`
should be run.

Note that you *might* need to run `xmkmf` and `make` as root, especially when
running `make install` to move the files around. Using `make` as an ordinary
user will likely result in *write access denied error* messages because you
lack write permission to system directories. Check also that the binaries have
the proper execute permissions.

Invoking `xmkmf` uses the Imake file to build a new Makefile appropriate for
your system. You would normally invoke `xmkmf -a`, to automatically do: 

```bash
make Makefiles 
make includes 
make depend 
```

This sets the variables and defines the library locations for the compiler and
linker. Sometimes, there will be no Imake file, instead there will be an
`INSTALL` or `configure` script that will accomplish this purpose. Run
`configure` as `./configure` to ensure that the correct script is called.
`README` included with the distribution will explain the install procedure. 

The preferred directory for new packages is `/usr/local/bin`, as this will keep
separate binaries not part of the original Linux installation. 

Packages originally targeted for commercial versions of UNIX may attempt to
install in the `/opt` or other unfamiliar directory. This will result in an
installation error if the intended installation directory does not exist. The
simplest way to deal with this is to create, as root, an `/opt` directory, let
the package install there, then add that directory to the `PATH` variable.
Alternatively, you may create symbolic links to the `/usr/local/bin` directory.

The general installation procedure is:

1. Read `README` and other docs.
1. Run `xmkmf -a`, or the `INSTALL` or `configure` script.
1. Check the Makefile.
1. If necessary: 

   ```bash
   make clean
   make Makefiles
   make includes
   make depend
   ```

1. `make`
1. Check file permissions.
1. If necessary:

   ```bash
   make install
   ```

TLDR:
```bash
./configure # or ./INSTALL
make
make install # as root
```

Notes: 
- You would not normally build a package as root. Doing an `su` to root is only
necessary for installing the compiled binaries into system directories.
- After becoming familiar with `make` and its uses, you may wish to add
additional optimization options passed to `gcc` in the Makefile . Some of these
common options: `-O2`, `-fomit-frame-pointer`, `-funroll-loops`, and
`-mpentium` (if you are running Pentium).
- After the make creates the binaries, you may wish to `strip` them. The
`strip` command removes the symbolic debugging information from the binaries,
and reduces their size, often drastically. *This disables debugging.*

### Prepackaged Binaries

TLDR: prepackaged binaries *can be* more trouble than they're worth. They may
be out of date, miss functionality from the full release, be broken. It helps
to have source code on hand, so that you can tinker with it and learn from it.
It may also be insecure, since you need to install all the packages from root,
so run signature checks on the packages before installing.

### Troubleshooting

#### Link Errors

- Suppose `make` fails with a `Link error: -lX11: No such file or directory`,
even after `xmkmf` has been invoked. This may mean that the *Imake* file was
not set up properly. Check the first part of the Makefile for lines such as:

  ```cmake
  LIB=            -L/usr/X11/lib
  INCLUDE=        -I/usr/X11/include/X11
  LIBS=           -lX11 -lc -lm
  ```

  The `-L` and `-I` switches tell the compiler and linker where to look for the
  library and include files, respectively. In this example, the X11 libraries
  should be in `/usr/X11/lib`, and the X11 include files should be in
  `/usr/X11/include/X11`. If this is incorrect for your machine, make the
  necessary changes to the Makefile and try the make again.

- Undefined references to math library functions, such as the following:

  ```cc
  /tmp/cca011551.o(.text+0x11): undefined reference to `cos'
  ```

  The fix for this is to explicitly link in the `math library`, by adding an
  `-lm` to the `LIB` or `LIBS` flags in the Makefile.

- In a very few cases, running `ldconfig` as root may be the solution.
`ldconfig` updates the shared library symbolic links.

- Some Makefiles use unrecognized aliases for libraries present in your system.
For example, the build may require `libX11.so.6`, but there exists no such file
or link in `/usr/X11R6/lib`. Yet, there is a `libX11.so.6.1`. The solution is
to do a `ln -s /usr/X11R6/lib/libX11.so.6.1 /usr/X11R6/lib/libX11.so.6`, as
root. This may need to be followed by a `ldconfig`.

- Some packages will require you to install updated versions of one or more
libraries. For example, the 4.x versions of the StarOffice suite from
StarDivision GmbH were notorious for needing a libc version 5.4.4 or greater.
If running an older version of StarOffice you would, as root, need to copy one
or more libraries to the appropriate directories, remove the old libraries,
then reset the symbolic links. **Caution**: Exercise extreme care in this, as
you can render your system nonfunctional if you screw up.

#### Other Problems

- If an installed Perl or shell script gives you a `No such file or directory error`
message, check the file permissions to make sure the file is executable and
check the file header to ascertain whether the shell or program invoked by the
script is in the place specified. The script has to begin with:

  ```pl
  #!/usr/local/bin/perl
  ```

  If Perl is in fact installed in your `/usr/bin` directory instead of the
  `/usr/local/bin` one, then the script will not run. There are two methods of
  correcting this. The script file header may be changed to `#!/usr/bin/perl`,
  or a symbolic link to the correct directory may be added:

  ```bash
  ln -s /usr/bin/perl /usr/local/bin/perl.
  ```

- Running a `configure` script creates a strange Makefile, one seemingly
unrelated to the package you are attempting to build. This means the wrong
configure ran, one found somewhere else in your path. Always invoke configure
as `./configure` to prevent this.

- Precompiled binaries that worked with an older library may bomb if you have
upgraded your library. The solution is to either recompile the applications
from the source or to obtain newer precompiled binaries. 

- Sometimes it is necessary to remove the `-ansi` option from the compile flags
in the Makefile. This enables `gcc`'s extra, non-ANSI features, and allows
building packages that require these extensions.

- Some programs require having `setuid` root, in order to run with *root
privileges*. The command to implement this is `chmod u+s filename`, as root
(note that the program must already be owned by root). This has the effect of setting
the *setuid* bit in the file permissions. This issue comes up when the program
accesses the system hardware, such as a modem or CD ROM drive, or when the SVGA
libs are invoked from console mode, as in one particularly notorious emulation
package. If a program works when run by root, but gives *access denied* error
messages to an ordinary user, suspect this as the cause.

**Warning:** A program with *setuid* as root may pose a security risk to your
system. The program runs with root privileges and thus has the potential for
doing significant damage. Make certain that you know what the program does, by
looking at the source if possible, before setting the setuid bit.

#### Tweaking and Fine Tuning

You may wish to examine the Makefile to make certain that the best compilation
options for your system are invoked. For example, setting the `-O2` flag
chooses the highest level of optimization and the `-fomit-frame-pointer` flag
results in a smaller binary (though debugging will then be disabled). **Do not
play around with this unless you know what you are doing, and in any case, not
until after a trial build works.**

### Final Steps

Read the software package documentation to determine whether certain
environmental variables need setting (`.bashrc`) and if the `.Xresources` file
needs customizing.

Most software packages come with one or more preformatted man pages. Copy the
`.man` files to the appropriate `/usr/man`, `/usr/local/man` directory (man1 -
man9), and rename it accordingly. For example, if `file.man` ends up in
`/usr/man/man4`, it should be renamed `file.4`. By convention, user commands go
in `man1`, games in `man6`, and administration packages in `man8`.

A few packages will not install the binaries in the appropriate system
directories, they are missing the `install` option in the Makefile.
Should this be the case, you can install the binaries manually by copying the
binaries to the appropriate system directory, `/usr/bin` or `/usr/local/bin` as
root, of course. Note that `/usr/local/bin` is the preferred directory for
binaries that are not part of the Linux distribution's base install.

Some or all of the above procedures should, in most cases, be handled
automatically by a `make install`, and possibly a `make install.man`or `make
install_man`. If so, the `README` or `INSTALL` doc file will specify this.
