# `xclip` & `xsel`

[***Table of Contents***](/README.md)

Some clarifications about how clipboards (generally) work are needed.

### Multiple Clipboards

"Clipboards" in Xorg are called selections. There are two main ones:

- **PRIMARY** - used for the currently selected text (highlighted), even if it
is not explicitly copied, and for middle-mouse-click pasting. In some cases,
pasting is also possible with a keyboard shortcut.
- **CLIPBOARD** - used for explicit copy/paste commands involving keyboard
shortcuts (`Ctrl-c`, `Ctrl-v`) or menu items. Hence, it behaves like the
single-clipboard system on Windows. Unlike PRIMARY, it can also handle multiple
data formats.

This is very convenient since you can copy and paste two different things.

There is also a **SECONDARY** one, but it doesn't have a purpose.

Please note that **nothing is copied until it is pasted.** E.g., if you select
some word in a terminal window, close the terminal and then try to paste it
somewhere else, it will not work because the terminal is gone and the text has
not been copied anywhere. 

If you want it to be preserved, paste it somewhere else first.

### `xclip`

By default, `xclip` puts text into your PRIMARY clipboard:

```bash
echo -n "123" | xclip
# same thing as:
# echo -n "123" | xclip -selection primary
```

To copy text into your CLIPBOARD clipboard:

```bash
echo -n "321" | xclip -selection clipboard
```

You can also specify the SECONDARY clipboard:

```bash
echo -n "213" | xclip -selection secondary
```

These can be shortened as 'p', 'c' and 's' respectively:

```bash
echo -n "123" | xclip -selection p # = primary
echo -n "321" | xclip -selection c # = clipboard
echo -n "213" | xclip -selection s # = secondary
```

To copy text from a file:

```bash
xclip file
# same thing as:
# xclip -t file
```

To paste (from PRIMARY by default):

```bash
xclip -o
```

To paste from CLIPBOARD:

```bash
xclip -o -selection c
```

`-f` will print whatever you passed into `xclip`:

```bash
echo 321 | xclip -selection c -f
```
```
321
```

`-r` will strip the last newline character, e.g., `pwd` prints a newline at the
end, it will be removed:

```bash
pwd | xclip -f -r
```

To copy an image:

```bash
# xclip -selection c -t image/png <image>
xclip -selection c -t image/png file.png
```

### `xsel`

It's very similar to `xclip`.

`-a` to append information to the selection:

```bash
xsel -a
```

`-c` to clear the selection:

```bash
xsel -c
```

- `-p` for PRIMARY
- `-s` for SECONDARY
- `-b` for CLIPBOARD

To output from the PRIMARY selection:

```bash
xsel -o -p
```

- `-k` makes your selections persist even after the programs they were selected
in exit
- `-x` swaps PRIMARY and SECONDARY
