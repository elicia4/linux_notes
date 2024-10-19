# Midnight Commander

It's is a shell file manager.

As always:

```bash
command -v md # to see that the command is installed
sudo apt install md # to install it on a Debian-based system
```

Launch it:

```bash
mc
```

There two different splits (panes). Each of these panes is attached to a
directory. You can navigate to two different directories, move and copy files
between them, delete files in them etc.

You can navigate with your mouse, but it's a lot faster to use shortcuts.

To navigate: 
- Up and Down, `Ctrl-P`, `Ctrl-N` to move between files
- `Ctrl-I` to switch between panes

There's a command line at the bottom, you can just type in the commands you
need and they will appear there. Note that not all commands works well there.
The commands you enter will target the currently focused pane. E.g., `rm`, `mv`
and `cp` work well there.

There's a menu at the top. The three options between `Left` and `Right` pertain
to `mc` itself. The `Left` and `Right` menus pertain to left and right splits
respectively.

You can change the theme of MC:
Options -> Appearance -> Skin: -> <select a new skin there> -> OK

You can strip colors completely, launch `mc` like so:

```bash
mc --nocolor
```

Take a look at the line at the bottom, below the command line. There are
numbers 1-10 with various options, they pertain to F-keys, so these are
`F1-F10`. As with the CLI, the active pane will receive the command.

To open a file in your default text editor, select it an press `F4`. To copy a
file, press `F5`. The button at the bottom can be pressed with the mouse as
well.

You can customize MC even further, go to: Options -> Layout. You can change the
split to be horizontal instead of vertical, you can hide the menubar, command
prompt, etc. 

A great option you can enable is Lynx-like motion: Options -> Panel options ->
Navigation: Lynx-like motion. With it enabled, you can navigate the files
system with `Left` and `Right`, go up and down the directory tree respectively.

Once you have everything set up, you can save the current config: Options ->
Save setup. The config will be saved to `~/.config/mc`.
