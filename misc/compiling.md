# Software Compilation

### General Terminology

*Compilation* is the process of converting source code into binary files
(machine code). 

Compilation is done by *compiler* programs (compilers). *Assemblers*
translate assembly language into machine language. Some compilers directly
translate high-level languages into machine code, some translate source code
into assembly code and pass it for further translation to an assembler.

*A linker* is used to form the connections between the output of the compiler
and the libraries that the compiled program requires.

There are programs that don't need to be compiled, they are executed directly
by a program called an *interpreter*. Each line is translated one by one,
whereas compiled programs are only translated once.

### C Program Compilation

Install `gcc`. You need `make`, the compiler and the linker:

```bash
apt install gcc make
pacman -S gcc make
```

After installing the necessary programs, you need to obtain source code for
your program of choice (`diction` will be used as an example):

```bash
mkdir src
cd src
ftp ftp.gnu.org # use "anonymous" as the login
```

Get the latest version:

```ftp
cd gnu/diction
ls
get diction-1.11.tar.gz
bye
```

You could've just as easily done this with `wget`, but `ftp` is more fun:

```bash
wget https://ftp.gnu.org/gnu/diction/diction-1.11.tar.gz
```

By default, source code installed by your distro is stored in `/usr/src`.
Source code that's intended to be used by multiple users and that is maintained
by the users should be stored in `/usr/local/src`.

Unpack the tarball file (`tar.gz`):

```bash
tar xzf diction-1.11.tar.gz
```

In general, source code is unpacked into a directory with the same name as the
tarball file. It's a good idea to inspect the contents of a tarball first,
since *it might not be well organized and make a mess out of your directory*:

```bash
tar tzvf tarfile | head
```

Examine the unpacked folder:

```bash
ls diction-1.11
```

`README`, `INSTALL`, `NEWS`, and `COPYING` are documentation files. Read the
`README` and `INSTALL` files carefully before attempting an installation:

```bash
ls *.c
ls *.h
```

The C files contain programs. The `.h` files are header files, they contain
descriptions of the routines included in a source code file.

The `#include "getopt.h"` line tells the compiler to read the `getopt.h` file
stored somewhere in the current directory (current source tree). 

These lines, on the other hand, refer to header files stored outside of the
current source tree and are supplied by the system:

```bash
#include <regex.h> 
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 
#include <unistd.h>
```

You can see them in `/usr/include`:

```bash
ls /usr/include
```

The header files were installed there during the installation of the compiler.

Finally, to build a program:

```bash
./configure
make 
```

The `configure` command analyzes the build environment. Since different
Unix-like systems are configured differently, this steps is necessary to
accommodate the differences between systems. Check that there are no error
messages, the program won't build until these errors are corrected. A
`Makefile` should've been created as the result of `./configure`:

```bash
less Makefile
```

The file describes the relationships and dependencies among the components that
comprise the finished program. The first part of the makefile defines variables
that are substituted in later sections of the makefile:

```cmake
CC=             gcc
```

Most of the makefile consists of lines, which define a target, in this case the
executable file `diction` and the files on which it is dependent:

```cmake
diction:        diction.o sentence.o misc.o getopt.o getopt1.o 
                $(CC) -o $@ $(LDFLAGS) diction.o sentence.o misc.o \ 
                getopt.o getopt1.o $(LIBS)
```

Later on, we see targets for `.o` files:

```cmake
diction.o:      diction.c config.h getopt.h misc.h sentence.h 
getopt.o:       getopt.c getopt.h getopt_int.h 
getopt1.o:      getopt1.c getopt.h getopt_int.h 
misc.o:         misc.c config.h misc.h 
```

They are handled by a general target, earlier in the file, that describes the
command used to compile any `.c` file into a `.o` file:

```cmake
.c.o: 
                $(CC) -c $(CPPFLAGS) $(CFLAGS) $<
```

Build the program with `make`:

```bash
make
```

After the program's finished, all the targets will be in the local directory.
The binaries `diction` and `style` are in the current folder. Run `make` again:

```bash
make
```

It only builds what needs building. For example:

```bash
rm getopt.o
make
```

Make keeps targets up-to-date, it insists that targets be newer than their
dependencies.

```bash
ls -l diction getopt.c
touch getopt.c
ls -l diction getopt.c
make
ls -l diction getopt.c
```

Some programs contain millions lines of code. In those kinds of projects,
`make` saves a great deal of time.

### Installing The Program

Well-packaged source code will often include a special make target called
`install`. This target will install the final product in a system directory for
use. Usually, this directory is `/usr/local/bin`, the traditional location for
locally built software. It's not writable, so use `sudo`:

```bash
sudo make install
```

Check if it's been installed:

```bash
which diction
man diction
```

So, the general process is:

```bash
./configure
make
sudo make install
```
