# `lf` 

Notes on [the video by Luke Smith](https://youtu.be/XOMj7JSGR78).

[***Table of Contents***](/README.md)

`lf` is a command line file manager. It's highly customizable, you can add in
file previews, file deletion, custom bash functions etc., I suggest using [the
configuration from Luke's
dotfiles](https://github.com/LukeSmithxyz/voidrice/tree/master/.config/lf).

You can navigate with vim bindings: 

- `j` - up
- `k` - down 
- `h` - up the directory tree
- `l` - down the directory tree, also opens files with the default program

`man` is also available:

```bash
man lf
```

- `space` - select files / directories
- `d` - cut 
- `y` - yank
- `p` - paste 

The configs are in `~/.config/lf`. 

### Luke's Config Stuff

The main file is `lfrc`, Luke's config also contains `scope`, it has to do with
previewing files, and `cleaner`, it has to do with deleting file previews. Take
a look at the beginning of `lfrc` to set everything up right.

With Luke's config, you can delete files with `D`. You can take a look at all
the other custom commands in `lfrc`, their bindings are at the end of the file.

Make sure to install all of the dependencies, mainly `ueberzug` for file
previews, fonts for emoji support etc. The `icons` file contains all of the
cute emojis. You also need `ffmpegthumbnailer` for video previews.

You can bind certain commands in the `zsh` configs, e.g., you can bind the `lf`
wrapper `lfub` to a key:

```bash
bindkey -s '^o' '^ulfub\n'
```

- `^u` deletes the line from cursor to beginning of the line 
- `\n` is the same as pressing enter

You can use `lf` to switch directories and bind it to `ctrl-o`:

```zsh
# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'
```

Add it to your `.zshrc`, press `ctrl-o`, navigate to the needed directory,
quit with `q` quit, and you will remain in that directory!

Show hidden files with `ctrl-s`.

#### i3wm `lf` Binding

You probably want to keybind quick access to `lf` in your window manager of
choice as well. Here's how I have it set up (i3 + zsh):

1. In my i3 config file:

```bash
bindsym $mod+o exec alacritty -e env LFCD_CALL=1 zsh
```

1. In my zsh config file:

```bash
if [ "$LFCD_CALL" -eq 1 ]; then lfcd; fi
```
