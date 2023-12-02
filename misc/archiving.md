# File Archiving

Notes taken on the "How to Archive Folders in Linux (tar and gzip tutorial) -
Linux Crash Course Series" video by LearnLinuxTV.

[***Table of Contents***](/README.md)

We will focus on `gzip` and `tar` commands, together they provide you with a
full archiving solution.

Use some temprorary and useless data for experimentation. For example, make a 
copy of the `/etc` directory:

    sudo cp -r /etc etc-copy 

Change ownership of the directory if it's not right:

    sudo chown user:user -R etc-copy 

### `tar`

The `tar` command allows us to combine multiple files into one archive file.
It's similiar to a `.zip` file, the difference being that a `.tar` file isn't
compressed, the files will be the same size when they're archived.

To create an archive of a directory:

    tar -cf etc_backup.tar etc-copy

- the `-c` option is for "create", create a new archive;
- the `-f` tells `tar` that you want to provide a filename;
- `etc.backup.tar` is the filename of the archive;
- `etc-copy` is the folder you're archiving.

A tar file is also caller a tarball. You can name your `.tar` files whatever
you want, you don't need to add `.tar`.

To look at the contents of a tarball without extracting it first:

    tar -tf etc_backup.tar

- `-t` gives a listing of the files inside the tar file;
- `-f` tells `tar` that you want to provide a filename;

You will get a lot of output. See how many lines you got:

    tar -tf etc_backup.tar | wc -l

Enable verbose mode with `-v`:

    tar -tvf etc_backup.tar
    
The output is a lot more detailed now. It's giving you the same info as `ls -l`
would give.

How do you restore something from backup? Delete the `etc-copy` directory
first:

    rm -rf etc-copy

To convert your backup back to a folder:

    tar -xf etc_backup.tar

- `-x` is for "extract"

The `etc-copy` directory is back, but there was no output from the command.
Make it verbose to make it clear:

    tar -xvf etc_backup.tar

Now the output is there. 

### `gzip`

Compression is useful for saving space, `gzip` is a great way to do that.

Let's say you copy the contents of an SD card from your camera, they usually
take up a ton of space. To compress a file:

    gzip filename

To uncompress a compressed `.gz` file:

    gunzip filename.gz # g-unzip

### Archive + compress

You should combine `tar` with `gzip`:

    tar -czvf etc-copy.tar.gz etc-copy # .tar.gz isn't mandatory, but
    # recommended since it makes it clear what the file is

- `z` compresses the tarball. This is it. This is the dedicated option that
  redirects to the `gzip` command.

You can view the contents of a `gzip`ped `tar` file:

    tar -tvf etc-copy.tar.gz 

To extract a `gzip`ped `tar` file:

    tar -xvf etc-copy.tar.gz 
