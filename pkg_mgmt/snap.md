# `snap`

Notes taken on the "The Linux Crash Course - What are "snap" Packages? " video
by LearnLinuxTV.

[***go back to README***](/README.md)

`snap` packages are a universal package format. Universal packages are Linux
packages that contain everything an application needs to run all in one
package, making it a self-contained application and also portable. Applications
that are packaged this way exist outside of your distribution's package manager
and are managed with separate tools.

`snap` packages are controversial, look up the reasons for that yourself if
you're interested.

### Understanding "Universal Packages"

- This concept aims to alleviate some of the burdens that developers often face
  while porting apps to Linux
- Since some of the major userspace applications have yet to be ported to
  Linux, universal apps may help
- Building Linux apps can be confusing to developers that aren't familiar with
  the platform. There are many distribtions and they are different
- Universal packages aim to remove the distribution out of the question
- Universal packages can be more secure, but you can't rely on that 100% of the
  time. Universal apps are largely assumed to be containers, but it's not
  always true. They are not always completely isolated from the system

Note that there are alternatives to `snap`, like `Flatpak` or `AppImage`.

### Goals of `snap` 

- `snap` packages were created by Canonical, the company behind Ubuntu
- Like other Universal Package formats, the goal is the same - developers can
  target one format, which simplifies development
- This technology is built-in to Ubuntu, but other distribtions have access to
  this as well. *The server version of Ubuntu has support of `snap` packages.*
  However, some cloud providers remove `snap` by default.
- To the end-user, applications packaged via `snap` are transparent (for the
  most part)
- The `snapd` service facilitates `snap` packages on supported systems. It's
  quite easy to set up

To see if `snap` is available:

    command -v snap

On Ubuntu, you can install it:

    sudo apt update && sudo apt install snapd

### Examples

To see available `snap` packages:

    snap find

Zoom out in case there's too much text. These are not the only available
packages.

To look for a specific package:

    snap find neovim

It looks for the argument in the name as well as in the contents of the
summary. Look at the `Publisher` column, there's a package whose publisher is
`neovim-snap`, the actual publisher of `neovim` itself. The `classic` parameter
in the `Notes` column, a snap package in the classic mode has access to files
outside of the user's home directory. It's better not to use classic unless
it's required.

To look up the info on a `snap` package:

    snap info nvim

Let's see what the difference is between the `apt` version and the `snap`
version:

    sudo apt install neovim;
    which nvim;
    nvim --version;

Note the version number, look up the `snap` version of neovim again:

    snap info nvim

`snap` versions are usually newer than `apt` versions. 

To install a package:

    sudo snap install --classic nvim

Don't include the `--classic` option habitually, only when you need it.

If you run `nvim` now, by default the `apt` version will be launched. To run
the snap version:

    /snap/bin/nvim

To update the snap packages:

    sudo snap refresh

The are updated automatically, you don't have to do this. You can see when
exactly your system installs snap packages:

    snap refresh --time

The second line is the timer, it tells when updates are installed. By default
they are updates 4 times withing 24 hours. Also the `last` time the packages
were updated is shown, you can also see the `hold` time, and the time when it
plans on doing it `next`. To add a hold:

    sudo snap refresh --hold=48h nvim

You can set the hold time to forever:

    sudo snap refresh --hold=forever nvim

If you want to disable that, set it to another value:

    sudo snap refresh --hold=1h nvim

To set your own update time window:

    sudo snap set system refresh.timer=00:00-05:00

Between midnight and 5am you might be sleeping/the server is underutilized. See
if the command worked:

    snap refresh --time

### Why the controversy?

- Some feel that Canonical has too much control over this technology
- Canonical pushes really hard to make this format successful, something that
  annoys users
- Snap Store is closed-source, `snap`s are locked to it
- Users may feel as if they didn't get a choice over which version gets
  installed, as if it's being forced. `snap` versions of packages may be
  unstable/slower

Try other package formats! See which ones you like! Decide for yourself what to
use and what to not use.
