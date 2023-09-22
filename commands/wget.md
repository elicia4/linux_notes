# The `wget` command

Notes taken on the "Linux Crash Course - The `wget` Command" video by
LearnLinuxTV.

[***go back to README***](/README.md)

The command allows you to directly download something from the internet without
a GUI. To see if it's installed:

    which wget

Let's say you want to download an archive that contains an app (not every app
is downloadable by `wget`). Let's download `wget`. Find a download link on the
`wordpress.org` website, right click on the `Download WordPress <version>` and
`Copy Link`, then paste it:

    # wget <link>
    # right now it's 
    wget https://wordpress.org/latest.zip

The `-O` lets you change the name of the downloaded file:

    wget -O wp.zip https://wordpress.org/latest.zip

This is especially useful for scripting. You can also change the location of 
the downloaded file with `-P`:

    wget -P ~/Downloads https://wordpress.org/latest.zip

You can resume an interrupted download, first start a download and interrupt
it. To resume use `-c`:

    wget -c https://wordpress.org/latest.zip

You can use an input file with `wget` to download a list of files, create a
file with a list of links first:

    wget -i file-name # i = input file    
