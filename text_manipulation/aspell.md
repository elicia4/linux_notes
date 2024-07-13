# The `aspell` spelling checker

[***Table of Contents***](/README.md)

`aspell` is an interactive spell checker. See if it's installed:

```bash
command -v aspell
```

To install `aspell` and the English dictionary for it with `pacman`:

```bash
pacman -S aspell aspell-en
```

There are other `aspell` dictionaries available for `aspell`:
1. [Main repositories](https://archlinux.org/packages/?q=aspell-)
1. [AUR](https://aur.archlinux.org/packages?SeB=n&K=aspell-)

It can intelligently check various types of files, not just plain-text. It's
also used by other programs to check for spelling errors. 

Create a file containing mistakes:

```bash
echo "Creete a faile contaenieng mestakes:" > filename.txt
```

To spellcheck a file:

```bash
aspell check filename.txt
```

The interface is incredibly intuitive. 

By default, `aspell` create a backup of the original file (with the `.bak`
extension). To instruct it not to do it:

```bash
aspell check --dont-backup filename.txt 
```

Or:

```bash
aspell check -x filename.txt 
```

To edit HTML files, use the `-H` option:

```bash
aspell check -H filename.html
```

The option ignores the tags and only the non-markup parts of the file are
checked. ALT tags are not ignored.
