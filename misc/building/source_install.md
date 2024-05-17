# Installing from Source

[***Table of Contents***](./ToC.md)

[***Source: Mine of
Information***](https://moi.vonos.net/linux/beginners-installing-from-source/)

### Introduction

This guide teaches you how to install software obtained directly from the
original authors rather than from the operating system.

### Concepts Discussed

- Development and distribution: independent software developers, multi-os
support, releases (archives), version-control
- Distributions: binary packages and package-managers
- Downloading: http, ftp, wget, checksums and signatures
- Archive files: tar, zip, gzip
- Common files: README and INSTALL; required dependencies
- Patching with sed/awk/patch
- Building and Installing: configure, make, cmake, perl and python
- Building and Installing Documentation
- Compiler settings and stripping; handing errors
- Post-installation

### Development and Distribution

The original software developers are sometimes referred as the *upstream
source* or simply *upstream*. The developers often refer to the distributions
that use their code, or the end-users as *downstream*.

Most open-source projects store their source code in a version-control system.
For such projects it is possible to download the very latest "in-progress"
files, or some other version of it. It is not very efficient to do this;
projects usually make regular *releases* by creating an *archive file*
containing all the relevant files. For projects that do not have a public
version-control system, such periodically released *archive files* are the only
way to obtain the sourcecode directly.

### Distributions, Binary Packages, and Compiling From Source

There are many *distributions* which do the work of finding, downloading and
tweaking the most used packages. Several also compile it, and make the
binary-form results available. There are many benefits: 

- quicker installation, 
- one location to find relevant software, 
- a supply of relevant security patches.

The distribution maintainers watch for security updates and make it easy for
end users to notice and install them.

However such distributions often don't include the very latest version of
software; if you need a newer version then you need to build it yourself.
You can customize your software at install-time, particularly to omit features
that you don't need. 

Distributions include a *package manager* that keeps a database of which
software is installed. It isn't a good idea to change the software on a machine
"behind the back" of the package manager; it could lead to trouble later. If
your distro has a package manager, then refer to this document and the disto
documentation to learn how to install software without confusing your package
manager. Usually this involves writing a *package specification* that describes
the software and using the local package manager to compile and install the
software. This applies to all distributions with package-managers, regardless
of whether applications are distributed in binary (pre-compiled) or source-code
form.

### Downloading and Security

The usual way to download an archive is by using a web-browser via the "http"
or less frequently the "ftp" protocol. 

When the correct URL is known, you can get files with `wget` or `curl` via http
or ftp.

Sites often have "mirror" sites set up, i.e. helpful people keep *copies* of
the files in various places around the world. The original site usually has a
list of the available mirrors, and you should choose one that is near to you.
This helps reduce the cost of network bandwidth on the original publisher, and
also lets you download faster.

Both the *http* and *ftp* protocols can be intercepted by undesirable parties
who can modify data as it downloads. Data can also be corrupted by accident
while underway (though this is uncommmon). And when using a mirror-site, it is
possible that someone has modified the files there. It is therefore a good idea
to *verify* that what you downloaded is what the original publisher intended.

Many sites provide an *md5sum* file for each archive file, which holds a
*checksum* of the contents of the file; sometimes a single *md5sums* holds
checksums for a number of other files. You should always obtain an md5sums file
from the *original site*, never a mirror. And you should download it via the
secure *https* protocol if possible. The unix `md5sum` command can be used to
compute the checksum of the big archive file, and compare it to the expected
values to ensure the contents are as expected.

To compute the sum of a single file:

```bash
md5sum file-to-check
```

You can then copy the output and find it in the webpage.

If the software provider provides an md5sums file which has a list of
(filename, checksum) pairs, then:

```bash
md5sum -c md5sums-file
```

This will look in your local system for every file listed in the file, compute
its checksum, and report an error if it's not the expected value.

Some software providers *sign* archive files instead of (or as well as)
providing an md5 checksum:

- download the provider's public key (using https where possible)
- download the "signature file", a `.sig` or `.asc` file which has the same
base name as the downloaded file
- then do (make sure `gpg` is installed):

  ```bash 
  # needed only once for each key, ie each "publisher"
  gpg --import {public-key}

  gpg --verify {signature-file-name}
  ```

The `verify` step decrypts the signature-file, revealing a checksum; it then
runs a checksum algorithm over the real file and checks that they are the same.

### Archive Files

An *archive* is a single file that contains within it a number of other files.
There are several different tools for creating such files but in all cases the
process is effectively to append all the individual files together, and then
add an "index" which contains the offset, length, name and other properties of
the original files so that they can be extracted again.

`tar` packs multiple files into a single "tar-format" archive file, which is
the most commonly-used format in open-source. Tar originally meant "tape
archive", but the format works well on disks too. Tar archives remember not
only the original names of files, but also their original Unix "owner id" and
*file-permissions*. The ownerid is seldom useful, but the file-permissions
are. Tar-format files usually end with `.tar`. Tar-format files containing
sourcecode are sometimes referred to as "tarballs".

`tar` doesn't compress the file contents. However source-code files do compress
very well and network bandwidth is always too slow and too expensive, so tar
files are usually compressed after creation, using a generic compression
application. The most commonly used compression type is `gzip`, resulting in
`.tar.gz` or `.tgz` files. Compression with `bzip2` is also common
(`.tar.bz2`). Occasionally `xz` compression will be used (`.tar.xz`).

Here are some example commands to extract files from a tar archive:

```bash
# Modern GNU tar options. This works for files compressed
# with gzip and bzip too
tar --extract --file filename

# Same as above
tar -xf filename

# Same as above. Leading "-" is optional
tar xf filename # best

# explicitly decompress gzip2-compressed file then
# pass uncompressed result directly into tar
gzip -cd filename.tgz | tar xf -

# same as above, but for bzip2-compressed files
bunzip2 -cd filename.tar.bz2 | tar xf -
```

**Warning:** unpacking a tar file can overwrite local files. By default, files
are unpacked into a subdirectory of the current directory, which should be safe
as long as your current directory is something appropriate. However *do not
trust any instructions that use the following options;* they may be trying to
trick you into modifying important local files:

```bash
-C or --directory
-P or --absolute-names
--transform or --xform
```

Most tar-files are created such that unpacking them creates a single
subdirectory, and all other files are placed into that directory. Sadly not
everybody follows this convention, so the tarfile expands its contents directly
into the current directory - which can create a big mess. It is therefore best
to check the contents of the tarfile before unpacking:

```bash
# Modern GNU tar
tar --list --file filename
# Same as above
tar -tf filename
# Same as above. Leading "-" is optional
tar tf filename # best

gzip -cd filename | tar tf -
bunzip -cd filename | tar tf -
```

Occasionally, archive files are distributed in `zip`. The Zip format works like
a combination of `tar` and `gzip` (it uses the same compression as `gzip` but
its own kind of internal "indexing"). Zipfiles do not preserve the original
unix ownerid or file-permissions. The contents of such a file can be extracted
with `unzip`.

Archive files should be unpacked when logged in as a normal user, not root.
This is an extra safety-measure to prevent any unintended file overwrites.
However the file-owner settings recorded in the tar-file are only preserved
when the user unpacking the archive is the root user, which is rarely
important.

### Common Files

Unpacked source-code archives usually contain a file named `README` and/or
`INSTALL` in the top-level directory. They give important information about how
to compile, install and configure the rest of the source-code in the downloaded
archive.

One important piece of information usually found in the `README` or `INSTALL`
is a list of other software that must be installed first. Any program you
download will require some local header-files, library-files and/or helper
tools to build or to run. If you don't get the prerequisites right, then the
application may not compile, or may compile but not run, or may get built
without certain optional features that you want.

A set of parameters can be passed to the build-process to modify it.

### Patching

Sometimes the downloaded software may not to work in your environment, and
somebody has already figured out how to tweak it to resolve the problem. The
person who solved the problem may publish their "tweak" in the form of a `sed`
or `awk` command, a shell-script containing multiple `sed`/`awk` commands, or a
patch file. Obviously, you need to be cautious about such changes.

The `sed` tool applies a regular-expression to each line in a textfile, and
replaces matching text with something else. `awk` does something similar, but
is more powerful.

A patchfile is created by using `diff` to compare two versions of the same file
and output the differences. `patch` can take the output of `diff` and apply it
to one of the files to "convert it" to the other version:

```bash
patch < diff_file.txt
```

There is no need to specify target files since the unified format already
contains the filenames in the header. The nice thing about patchfiles is that
it is quite human-readable, i.e. it is reasonably easy to see what changes will
be made.

### Build Systems: `configure`, `make`, `cmake`, etc.

The software developers who created the software you downloaded need some way
of compiling and installing that software on their own machines. Whatever
config files are necessary for the tools they use are almost always included in
the archive file. However they cannot support every possible configuration in
the world.

The installation process is needed to convert the source-code into a form that
the computer can execute, and then to place all the necessary files into
directories that are listed in `$PATH` (so that you can execute those files).
Installing modules for interpreted languages is slightly different; those files
get installed where the interpreter (e.g. `python` or `perl`) can find them,
rather than in `$PATH` directly.

#### Configure and Make

The most widely-spread tool used to manage the compilation and installation of
source-code is `make`. Make is an application which takes a configuration-file
(called a `makefile`) that contains a list of rules, most of the form:

```cmake
when TARGET-FILE is older than SOURCE-FILE then SOME-ACTION
```

The `TARGET-FILE` is the end product, or some intermediate stage. The
`SOURCE-FILE` is the source-code, or some intermediate artifact. The
`SOME-ACTION` is usually the invocation of a compiler, a linker, or similar
which recreates the `TARGET-FILE`. Makefiles are complicated, more can be
learned about them in the [An example Makefile section](#an-example-makefile).

Unfortunately, although `makefile` syntax is very powerful it still isn't
enough to be able to handle all the possible ways that computers can be
configured, and all the possible ways that the person installing the software
may wish to compile the application. Many software packages therefore come with
a shell-script named `configure` and a template "makefile" named `Makefile.in`.
The `configure` script takes a list of configuration options, and converts the
template "makefile" into a real "makefile" customised for the local computer
and the installer's wishes. The installation sequence therefore usually goes
like:

```bash
# unpack and read documentation
tar xf filename
cd {directory created by above step}
less README
less INSTALL

# generate customised makefile
./configure {some options ...}

# compile everything in the local directory
make

# update global directories
sudo make install # obviously be careful with this
```

By the way: the `configure` script is auto-generated by software called
`autotools`, but that doesn't matter to the person using it.

Configure is usually invoked as `./configure` to avoid two possible problems:

- Some users don't have "." in `$PATH`. In particular, root doesn't have this
for security reasons
- Some users don't have "." as the first entry in `$PATH`, meaning that the
wrong configuration script might get run

In general, it is best to perform all steps except `make install` as a normal
user, not root. This avoids mistakes and possibly some attacks (though as the
`install` step is done as root that isn't much protection). However installing
software into `/bin` or `/usr` usually requires administration privileges.

Some projects provide a `makefile` but no `configure` script; in this case the
`configure` step above can be omitted. 

If your system doesn't have `sudo`, manually switch to root:

```bash
su # enter the root password
make install
exit
```

For most software, the `configure` and `make` commands can be run in the same
directory as the source-code, as shown above. The result is that new files
generated during compilation get mixed together with the originals, which is
somewhat messy, but `make clean` can be used to tidy that up later. However for
some software it is necessary to create a temporary directory and then perform
the build-steps there; the project documentation should indicate if this is
necessary. Some people consider it better to always build from a temporary
directory. For example:

```bash
# unpack into a directory {packagename}
tar xf filename

# create separate build directory
mkdir {packagename}-build

# compile everything in the separate build directory
# move to new build directory
cd {packagename}-build 
# execute the configure command in the build directory
../{packagename}/configure {some options}
make

# update global directories
sudo make install
```

#### Other Build Tools

Another build-tool is `cmake`. `cmake` works somewhat like `configure`; it
generates a makefile whose content depends on the options passed to `cmake`,
and on features of the local system. The steps require to build a `cmake`-based
package are identical to the `configure`/`make` examples above except that the
`configure` step is replaced by:

```bash
cmake . -DCMAKE_BUILD_TYPE=Release {some options ...}
```

As always, check the project's documentation for instructions on how to build.

Some projects use build-tools based on `python` or `perl` rather than `make`.
The principles are still fairly similar.

Software which does not need to be compiled usually has a fairly simple and
quick installation process. In particular, applications written in `perl` or
`python` can be installed just by copying the files into the relevant location.
These projects nevertheless include a program or script in the archive-file
which performs this task, rather that requiring the installer to do this
manually.

#### Environment Variables

Options to configure the compilation and installation of an application are
usually passed as parameters to `configure` or `make`. However sometimes
configuration options are passed via environment variables instead. These can
be specified by placing the definitions on the start of the command:

```bash
NAME=tom ENABLE_FOO=no ./configure
```

Which options are available is normally described in the archive's `README` or
`INSTALL` files, or on the project website. Sometimes the available options can
be seen by running `./configure --help`. 

#### Building and Installing Documentation

Some projects provide documentation which can be "installed" so it is
accessible via normal system documentation viewers such as `man` or `info`.
Some provide documentation in HTML form, which usually gets installed under
`/usr/share/doc`. Sometimes this documentation is included in the "standard"
archive file, and sometimes it is a separate (optional) download. Sometimes the
documentation is installed as part of `make install`, and sometimes a separate
command must be used. And sometimes the documentation is delivered in a
"ready-to-use" form, but sometimes it is delivered in a kind of "raw form" that
must be processed before being installed - rather like source-code needs to be
compiled.

As should be clear by now, the variety of approaches to delivering
documentation is so wide that no really useful advice can be given here. See
the `README` and `INSTALL` files in the downloaded archive, and the project
website for guidance.

#### Other Build Targets

As well as commands to compile everything (`make`) and to install the
previously-compiled programs (`make install`) or documentation, there are a few
other common possibilities.

`make clean` usually removes all generated files, i.e. leaves the directory as
it was after the files were unpacked from the archive.

#### Invoking a Compiler

As noted above, the most common step performed by `make` or `cmake` is to
invoke a compiler. The local system must have the appropriate compilers
installed.

This is also the step that is most likely to fail (along with linking).

If the compilation step fails with an error-message about not being able to
find a header-file, or not being able to find a library-file then you have
probably not installed all of the pre-requisites - reread the `README` and
`INSTALL` files. In some cases, the missing prerequisite is optional, in which
case there will be a parameter that can be passed to `configure` or an
environment variable which can be set to allow the software to be installed
without that prerequisite. Double-check the parameters you specified, and if
they seem correct then the project documentation is the best resource for
resolving such issues.

Compilers have a range of options that can potentially improve performance.
However you should only mess with these if you have plenty of experience. If
you need this document, then just leave compiler options at their defaults!

The output of compiling and linking (the executables) usually have significant
amounts of data in them which are useful for debugging the programs, but not
useful for "normal end users". This information can be removed from the
executable files: 

```bash
strip {filename}
```

Smaller programs will save disk-space and also load slightly faster. Unless you
are intending to debug the program, using `strip` is a good idea.

### Post-Installation Configuration

Some applications can have their behaviour customised via *configuration files*
read on application startup. Often applications install *default versions* of
the configuration files somewhere under `/usr` or `/etc`. Inspect the output of
`make install` to see which config files have been installed. Configuration
options should also be documented in `README` or `INSTALL`, or on their
website.

### An Example Makefile

When building packages from source-code, it is not unusual for compilation
errors to occur. It is sometimes possible to diagnose and fix the problem by
inspecting the makefile, i.e. a basic understanding of makefile syntax can be
helpful. Here is a very brief example of the basic syntax and functionality;
for further details see the `make` documentation or one of the many tutorials
available online.

A sample makefile to build an executable called `prog` which has one 'c'
sourcefile, one headerfile and uses one library (which it also builds from a
single 'c' sourcefile) could look like the following:

```make
prog: prog.c prog.h libmylib.a
  gcc -o prog prog.c -L. -lmylib

libmylib.a: libmylib.o
  ar -rcs libmylib.a libmylib.o

libmylib.o: libmylib.c libmylib.h
  gcc -c -o libmylib.o libmylib.c
```

The form of the entries (rules) are:

```make
target: dependency1 [dependency-n ...]
<tab> command to execute
...
```

For each "rule", if the target is missing or older than any of the dependencies
(based on file timestamps), then the command(s) are run to (re)create the
target. However each dependency is first tested to see if there is a rule that
has *it* as a target. If so, that target is recursively evaluated, i.e.
(re-)built if it is missing or older than its dependencies.

Thus in the above set of rules, a change in `libmylib.c` will cause
`libmylib.o` to be rebuilt. Then `libmylib.a` is regenerated and finally `prog`
is rebuilt.

Makefiles can get very complicated and many are automatically generated, but
the above principles always apply.
