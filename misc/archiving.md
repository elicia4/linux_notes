# File Archiving

There are notes on [this video,](https://www.youtube.com/watch?v=2iwumBcfd58)
man pages, and other resources on the Internet.

[***Table of Contents***](/README.md)

Archiving is useful for many tasks, such as backing up files and sending them
over the internet. Archiving helps us get the most data into the smallest
available space. This is done through data compression, the process of removing
redundancy from data. Note that compressing *already compressed* files is
usually ends up creating bigger files, for example `.jpg` file are already
compressed.

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

- `-c` is for "create", create a new archive;
- `etc.backup.tar` is the filename of the archive;
- `etc-copy` is the folder you're archiving.
- `-t` gives a listing of the files inside the tar file;
- `-f` tells `tar` that you want to provide a filename;
- `-r` append files to the end of an archive
- `-x` is for "extract"

A tar file is also caller a tarball. You can name your `.tar` files whatever
you want, you don't need to add `.tar`.

To look at the contents of a tarball without extracting it first:

    tar -tf etc_backup.tar

You will get a lot of output. See how many lines you got:

    tar -tf etc_backup.tar | wc -l

Enable verbose mode with `-v` for more detailed listing:

    tar -tvf etc_backup.tar
    
The output is a lot more detailed now. It's giving you the same info as `ls -l`
would give.

How do you restore something from backup? Delete the `etc-copy` directory
first:

    rm -rf etc-copy

To extract your backup back to a folder:

    tar -xf etc_backup.tar

The `etc-copy` directory is back, but there was no output from the command.
Make it verbose to make it clear:

    tar -xvf etc_backup.tar

Now the output is there. Note that extracted files are owned by the user who
performed the restoration.

Another interesting behavior of `tar` is the way it handles pathnames in
archives. The default for pathnames is relative, rather than absolute. `tar`
does this by simply removing any leading slash from the pathname when creating
the archive.

It’s possible to limit what is extracted from the archive. For example, if we
wanted to extract a single file from an archive, it could be done like this:

    tar xf archive.tar pathname

Multiple pathnames may be specified. 

The GNU version of `tar` supports wildcards:

    tar xf ../playground2.tar --wildcards 'home/me/playground/dir-*/file-A'

`tar` can be used with `find`:

    find playground -name 'file-A' -exec tar rf playground.tar '{}' '+'

`tar` can also make use of both standard input and output:

    cd
    find playground -name 'file-A' | tar cf - --files-from=- | \
    gzip > playground.tgz

We used the `find` program to produce a list of matching files and piped them
into `tar`. If the filename `-` is specified, it is taken to mean standard
input or output, as needed. The `--files-from` option (which may also be
specified as `-T`) causes `tar` to read its list of pathnames from a file
rather than the command line. Lastly, the archive produced by `tar` is piped
into `gzip` to create the compressed archive `playground.tgz`. `.tgz` is for
`gzip`-compresed tar files, `.tbz` is for `bzip2`-compressed tar files.

### `gzip`

Compression is useful for saving space, `gzip` is a great way to do that.

Let's say you copy the contents of an SD card from your camera, they usually
take up a ton of space. To compress a file:

    gzip filename

To uncompress a compressed `.gz` file:

    gunzip filename.gz # g-unzip

You can view the contents of a zipped file without unzipping it:

    gunzip -c file # or zcat file

Same with `less`:

    zless file

`gzip` options:
- `-c` - write output to standard output; keep the original files unchanged
- `-d` - decompress, `gzip -d` == `gunzip`
- `-f` - force compression even if a compressed version of the original file
  already exists
- `-h` - display usage information
- `-l` - list compression statistics for each file compressed
- `-r` - recursive
- `-t` test the integrity of the compressed file and quit
- `-v` - verbose
- `-number` - regulate speed and compression. Number ranges from 1 to 9, the
  more the slower but the better the compression. `1` == `--fast`, `9` ==
  `--best`. 6 is the default.

You can use `gzip` in many interesting ways, for example:

    ls -l /etc | gzip > listing.txt.gz

### `bzip2`

`bzip2` is also a file compressor, it uses a different compression algorithm,
it's slower but achieves better compression:

    bzip2 file
    bunzip2 file.bz2

The extensions of compressed files is `.bz2`. All the options of `gzip` are
supported, except for `-r` and `-number`, here it selects block size, `--fast`
doesn't make significantly faster. To view files:

    bzcat file.bz2

`bzip2` comes with a built-in recovery program called `bzip2recover`.

### Archive + compress

You combine `tar` with `gzip`:

    tar -czvf etc-copy.tar.gz etc-copy # .tar.gz isn't mandatory, but
    # recommended since it makes it clear what the file is

- `z` compresses the tarball. This is the dedicated option that redirects to
  the `gzip` command.
- `j` is `bzip2` compression option.

You can view the contents of a `gzip`ped `tar` file:

    tar -tvf etc-copy.tar.gz 

To extract a `gzip`ped `tar` file:

    tar -xvf etc-copy.tar.gz 

### File Transfer

You can transfer archived files over a network with `ssh` and `tar`:

    ssh remote-sys 'tar cf - Documents' | tar xf -

### `zip`

`zip` is another tool, it's both an archiver and a compressor:

    zip -r Docs.zip Documents

You have to specify the `-r` option, otherwise the contents of the directory
won't be included.

To extract the contents of a `.zip` file:

    unzip Docs.zip

If an existing archive is specified with `zip`, it's updated rather than
replaced. You can extract files selectively:

    unzip -l Docs.zip Docs/family/photo.png

- `-l` lists 
- `-v` - verbose

It's possible to pipe a list of filenames to `zip` with `-@`:

    find . -name "filename" | zip -@ archive.zip

`zip` accepts standard input:

    ls -l /etc/ | zip ls-etc.zip -

`unzip` supports sending its output to standard output:

    unzip -p ls-etc.zip | less

To unzip a `.7z` file:

    7z x file.7z
