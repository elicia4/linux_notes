# $PATH

Notes taken on the "What is $PATH on a Linux Shell? (The Linux Crash Course
Series)" video by LearnLinuxTV.

[***Table of Contents***](/README.md)

`$PATH` is a variable in your Linux shell which includes a listing of
directories that include binaries, you can run them from your terminal exactly
because they are included in the `$PATH` variable.

`$PATH` allows us to shorten commands. To see the value of `$PATH`:

    echo $PATH

The directories are separated by colons (`:`).

Let's create an example script:

    echo -e "#\!/bin/bash\n
    echo 'Hello World!'" > mycmd.sh;
    chmod +x mycmd.sh;
    ./mycmd.sh

If you move to another directory, you won't be able to run it. Take a look at 
the directories inside `$PATH`. Move `mycmd.sh` there and see if you can run it
from any directory now:

    sudo mv mycmd.sh /usr/local/bin

Move to another directory and run it:

    cd Documents;
    mycmd.sh;

It should have worked. To see where a command is located:

    which command-name # for example: which ls

You can add new directories to `$PATH` too. You can store your scripts in your
local `bin` directory:

    mkdir ~/bin

Create a new `$PATH` variable:

    PATH=$PATH:~/bin

You added `:~/bin` to the existing `$PATH` variable. Add as many as you want to
add separated by colons (`:`).

To make your new `$PATH` survive closing of your terminal, add the new `$PATH`
to your shell config file, for example with `bash`:

    echo "PATH=$PATH:~/bin" >> .bashrc

Or better yet add this to the end of `.bashrc`:

```
if [ -d ~/bin ]
then
    PATH=$PATH:~/bin
fi
```
