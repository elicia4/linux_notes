# The `nano` Command-Line Text Editor

Notes taken on the "Linux Crash Course - nano (command-line text editor)" video
by LearnLinuxTV

[***go back to README***](/README.md)

To check if `nano` is installed:

    which nano

To install `nano` on a Debian-based system:

    sudo apt install nano

The simplest way to start `nano` is to run:

    nano

As you can see on the top, it says "New Buffer", which means that it's just a
blank slate and not a file that already exists on your system.

You can just start typing!

    > Hello, nano!

Take a look at the stuff at the bottom. `^` represents the Ctrl key. You can 
hold Ctrl and any of the letters shown at the bottom to get various effects.

Write Out (`^O`) means save. You can give your new file a name in the following
prompt and then press Enter.

To exit, press `^X`. If you don't indicate a save path, your file will be saved
to your current directory:

    ls

To keep on editing the file (or edit any file really):

    nano file-name

If a file you want edit is not writable, `nano` will let you know:

    nano /etc/ssh/sshd_config

To search for something, use `^W`. 

Copy the file locally so that you can play around with it:

    cp /etc/ssh/sshd_config .

To cut an entire line, use `^K`. To uncut (or paste), use `^U`, this works
since when you cut the line it was put in the paste buffer.

To get help, use `^G`. The `M-` is the meta-key, it's bound to either Alt, Cmd,
or Esc key (it was alt in my case). 

You can start `nano` at a specific line number, if you know the line number
that you want to edit, let's say it's 15:

    nano +15 file

You can open files in view-only mode:

    nano -v file

It can be useful if you only need to *view* a file, without editing it.

You can go to a particular line from inside `nano` by pressing `^W`, note the
new options, press `^T`, enter the number and then press Enter.

`nano` has spell-checking support, to use it install the spell package:

    sudo apt install spell

To check the spelling, use `^T`. Enter the replacement word. Confirm with `Y`,
to break out of the spell check mode, press `^C`.
