# The "rsync" file-copying tool

Notes take on this video by LearnLinuxTV: https://youtu.be/KG78O53u8rY

[***Table of Contents***](/README.md)  

To check if `rsync` is installed:

    command -v rsync

If you see output with the path to a binary named `rsync`, you have it
installed. If you have no output, use your package manager to install it. With
`apt`:

    sudo apt install rsync

The basic idea behind `rsync` is simple: you use it to transfer files from one
place to another. You can transfer anything to anywhere, as long as you have
access to what you're transferring and the location you're transferring to.

By default `rsync` uses `ssh` to transfer files, just like `scp`. The main
difference is the range of options you can use to move your files, `rsync`
being a much more customizable and detailed option.

The basic syntax looks like this:

```
rsync <dir1> <dir2>
```

These directories can be on a local system, or a remote one. Essentially, this
command syncs the data from `dir1` to `dir2`. One of these directories could
be a directory where and NFS or Samba share is mounted to, so even though it
looks like we're copying data locally, we're effectively moving data to a
remote server, even with this syntax.

`rsync` doesn't do a bi-directional sync, that is, it doesn't sync your
directrories both ways. In the example above, what `rsync` does is it takes the
contents of `dir1` and syncs them to `dir2`. The second directory might have
things inside of it, by default `rsync` will just copy the contents of `dir1`
to `dir2`, it's not going to make both directories identical. `rsync` is more
of a one-way utility.

Prepare an example folder you will play around with:

    mkdir r_notes # create a dir called r_notes
    touch r_notes/{1..9}_note.md # create 9 notes inside of it 
    echo "I am a note" > r_notes/{1..9}_note.md # add "I am a note" to them

When using `rsync`, make sure you have access to everything you need before you
start the sync. Test both the destination and the source directories. Let's try
it out with the `--dry-run` and `-r` options:

```
rsync -r --dry-run <dir-to-back-up> <username>@<IP/NAME>:<destination>
# FOR EXAMPLE
rsync -r --dry-run r_notes admin@remote-server:/home/admin/backup
```

What `--dry-run` does is activate a demo mode, it's not actually going to copy
anything, but it's going to connect to the destination, check what is there and
calculate what it would have done if `--dry-run` was not included as an option.

`-r` stands for recursive, it's required when you want to transfer directories
over.

...and nothing happened. Activate verbose mode with the `-v` option to get more
details:

```
rsync -rv --dry-run r_notes admin@remote-server:/home/admin/backup
```

The output should be a lot more detailed now. Now do it without the `--dry-run`
option:

```
rsync -rv r_notes admin@remote-server:/home/admin/backup
```

Notice that there is no `(DRY RUN)` at the end of the output. Check out the
remote directory, the files are there!

The basic workflow is:  

- Run `rsync` with `--dry-run` and check that it's doing exactly what you want
- Run it for without `--dry-run` 

With `rsync` you can also copy files from the target and move them to a local
directory, doing the reverse of what you've just done.

First, remove all files from the local testing directory:

```
cd r_notes
rm *
```

Copy the files locally:

```
rsync -rv admin@remote-server:/home/admin/backup/r_notes/ r_notes/
```

You're simulating a scenario when you accidentally delete the contents of the
`r_notes` directory and restoring them from your backup location.

Let's say that a sync goes wrong and a file has a typo in its name after
transfer, for example you get a `1_note.md5` file instead of the `1_note.md`
file after transfer. You can fix it by renaming it, and then moving the local
files to the destination again. But when you check the contents of the remote
directory, both the `1_note.md5` and `1_note.md` are there. That's because
`rsync` doesn't sync deletions by default. `rsync` just copied files to the
target, it didn't replace the original one, it is not a true sync. If you
rename a file the same thing will happen. 

To fix this problem, use the `--delete` option, what is does it deletes all
files in the target directory that don't exist in the local directory:

```
rsync -rv --delete r_notes/ admin@remote-server:/home/admin/backup/r_notes/ 
```

Another thing to notice is that with these options, the modification dates
will not match. To check modification dates, run `ls -l`. To preserve metadata
(including the modification times), use the `-a` option, or the archive mode:

```
rsync -rva --delete r_notes/ admin@remote-server:/home/admin/backup/r_notes/ 
```

You can also use the `-z` option, which is going to compress the files as they
transfer. In a situation when you're contending with a slower connection, this
might help you get the transfer done quicker. Only do it when it benefits you:

```
rsync -rvaz --delete r_notes/ admin@remote-server:/home/admin/backup/r_notes/ 
```

To remove files locally after they have transferred (that is, remove source
files), use the `--remove-source-files` option:

```
rsync -rva --remove-source-files r_notes/ admin@remote-server:/home/admin/backup/r_notes/ 
```

^This makes it more of a transfer rather than a sync.
