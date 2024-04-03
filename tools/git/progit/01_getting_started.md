# Getting Started

Version control is a system that records changes to a file or set of files over
time so that you can recall specific versions later. Using a VCS also generally
means that if you screw things up or lose files, you can easily recover.

### The Three Stages

Git has three main states that your files can reside in: modified, staged, and
committed:

- Modified means that you have changed the file but have not committed it to
  your database yet.
- Staged means that you have marked a modified file in its current version to
  go into your next commit snapshot.
- Committed means that the data is safely stored in your local database.

This leads us to the three main sections of a Git project: the working tree,
the staging area, and the Git directory.

**The working tree** is a single checkout of one version of the project. These
files are pulled out of the compressed database in the Git directory and placed
on disk for you to use or modify.

**The staging area** is a file, generally contained in your Git directory, that
stores information about what will go into your next commit. Its technical name
in Git parlance is the "index", but the phrase "staging area" works just as
well.

**The Git directory** is where Git stores the metadata and object database for
your project. This is the most important part of Git, and it is what is copied
when you clone a repository from another computer.

The basic Git workflow goes something like this:
1. You modify files in your working tree.
2. You selectively stage just those changes you want to be part of your next
   commit, which adds only those changes to the staging area.
3. You do a commit, which takes the files as they are in the staging area and
   stores that snapshot permanently to your Git directory.

If a particular version of a file is in the Git directory, it's considered
*committed*. If it has been modified and was added to the staging area, it is
*staged*. And if it was changed since it was checked out but has not been
staged, it is *modified*.

### Installation

```bash
sudo dnf install git-all # for Fedora
sudo apt install git-all # for Debian
# etc. etc.
```

### Installing from Source

You need: autotools, curl, zlib, openssl, expat, and libiconv. With `apt`:

```bash
sudo apt-get install dh-autoreconf libcurl4-gnutls-dev libexpat1-dev \
gettext libz-dev libssl-dev
```

In order to be able to add the documentation in various formats (doc, html,
info), these additional dependencies are required:

```bash
sudo apt-get install asciidoc xmlto docbook2x
```

When you have all the necessary dependencies, you can go ahead and grab the
latest tagged release tarball from [this GitHub
page](https://github.com/git/git/tags).

Then compile and install:

```bash
tar -zxf git-2.8.0.tar.gz
cd git-2.8.0
make configure
./configure --prefix=/usr
make all doc info
sudo make install install-doc install-html install-info
```

After this is done, you can also get Git via Git itself for updates:

```bash
$ git clone https://git.kernel.org/pub/scm/git/git.git
```

### First Time Git Setup

`git config` allows you to set configuration variables that control all aspects
of `git`. These variables are stored in three different places:

1. `[path]/etc/gitconfig`: Contains values applied to every user on the
   system and all their repositories. The option `--system` reads and writes
   from this file specifically. 
2. `~/.gitconfig` or `~/.config/git/config`: Values specific personally to you,
   the user. You can make Git read and write to this file specifically by
   passing the `--global` option, and this affects all of the repositories you
   work with on your system. 
3. `config` in the Git directory (`.git/config`) of whatever repository you're
   currently using: Specific to that single repository. You can force Git to
   read from and write to this file with the `--local` option, but that is in
   fact the default. Unsurprisingly, you need to be located somewhere in a Git
   repository for this option to work properly.

Each level overrides values in the previous level, so values in `.git/config`
trump those in `[path]/etc/gitconfig`.

You can view all of your settings and where they are coming from using:
```bash
git config --list --show-origin
```

### Identity, Editor, Default Branch Name

The first things you should set are your email address and user name. *Every
Git commit you do uses this information*. Let's set them as global:

```bash
git config --global user.name "John Doe"
git config --global user.email "john_doe@example.com"
```

You can specify the default text editor that's used when Git needs you to type
in a message. If it's not configured, Git will use your system's default
editor. To set it to `nvim`:

```bash
git config --global core.editor nvim
```

When you create a repository (`git init`), Git will create a branch called
"master" and use it by default. You can set a different name for the default
branch:

```bash
git config --global init.defaultBranch main
```

To check that everything is configured correctly:

```bash
git config --list
```
You may see keys more than once, since there are multiple config files. It ends
up using the last key it sees. You can check the value of a specific variable:

```bash
git config user.name
```

It's possible to check which file had a final say in setting a value:

```bash
git config --show-origin user.name
git config --show-origin rerere.autoUpdate
```

### Getting Help

There are three ways to manual page help for any Git command:

```bash
git help <verb>;
git <verb> --help;
man git-<verb>;
```

E.g.:

```bash
git help config
```

If the manpages and this book aren’t enough and you need in-person help, you
can try the `#git`, `#github`, or `#gitlab` channels on the Libera Chat IRC
server, which can be found at [https://libera.chat/](https://libera.chat/).

There's a more concise "help" option in case you just need a quick refresher:

```bash
git add -h
```
