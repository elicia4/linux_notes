# The `nano` Command-Line Text Editor

Notes taken on the "Linux Crash Course - nano (command-line text editor)" video
by LearnLinuxTV

[***Table of Contents***](/README.md)

To check if `nano` is installed:

```bash
which nano
```

To install `nano` on a Debian-based system:

```bash
sudo apt install nano
```

The simplest way to start `nano` is to run:

```bash
nano
```

As you can see on the top, it says "New Buffer", which means that it's just a
blank slate and not a file that already exists on your system.

You can just start typing!

```bash
Hello, nano!
```

Take a look at the stuff at the bottom. `^` represents the Ctrl key. You can 
hold Ctrl and any of the letters shown at the bottom to get various effects.

Write Out (`^O`) means save. You can give your new file a name in the following
prompt and then press Enter.

To exit, press `^X`. If you don't indicate a save path, your file will be saved
to your current directory:

```bash
ls
```

To keep on editing the file (or edit any file really):

```bash
nano file-name
```

If a file you want to edit is not writable, `nano` will let you know:

```bash
nano /etc/ssh/sshd_config
```

To search for something, use `^W`. 

Copy the file locally so that you can play around with it:

```bash
cp /etc/ssh/sshd_config .
```

- `^K` - cut an entire line
- `^U` - uncut (paste)

This works since when you cut the line it was put in the paste buffer.

To get help, use `^G`. The `M-` is the meta-key, it's bound to either Alt, Cmd,
or Esc key (it was Alt in my case). 

You can start `nano` at a specific line number, if you know the line number
that you want to edit, let's say it's 15:

```bash
nano +15 file
```

You can open files in view-only mode:

```bash
nano -v file
```

It can be useful if you only need to *view* a file, without editing it.

You can go to a particular line from inside `nano`: 
- press `^W`
- note the new options
- press `^T`
- enter the desired line number 
- press Enter

`nano` has spell-checking support, to use it install the spell package:

```bash
sudo apt install spell
```

To check the spelling, use `^T`. Enter the replacement word. Confirm with `Y`,
to break out of the spell check mode, press `^C`.

### Structure of `nano`

There's a titlebar at the top of the editor, it consists of three sections:
- left - `nano` version
- center - filename (or "New Buffer" if the file has no name yet)
- right - displays "Modified" if the file was edited since last saved/opened

The statusbar is the third line from the bottom of the screen. It shows
important and informational messages:
- error messages (editor and others)
- questions to the user
- user input (search strings, filenames, etc.)

The Shortcut Lists are the two lines at the bottom that show the editor's
commonly used functions.

### Esc

You can enter Control key sequences with Esc:
- press Esc twice
- press the desired key

You can enter Meta key sequences with Esc:
- press Esc once
- press the desired key

You can press Esc twice, type a three-digit number (000 - 255), that will enter
the character with the corresponding value. E.g, 255 - ÿ.
