# `tee`

[***Table of Contents***](/README.md)

`tee` reads from standard input and writes to standard output (to the screen)
*and* files. This is useful for capturing a pipeline's contents at an
intermediate stage of processing:

```bash
ls /usr/bin | tee ls-contents.txt | grep -i .sh
```

`tee` will redirect the output of `ls /usr/bin` to `ls-contents.txt` and pass
standard output along to `grep`.

Another example on Debian/Ubuntu:

```bash
dpkg --get-selections | tee packages.list 
```

`dpkg --get-selections` lists all installed packages.

Whenever you update your system:

```bash
sudo apt dist-upgrade | tee update.log
```

You can write to multiple files:

```bash
ls | tee 1.txt 2.txt 3.txt
```

E.g.:

```bash
dpkg --get-selections | tee /var/log/packages.log /mnt/reports/selections.log
```

Obviously this command will fail if you don't have permissions to the files you
write to. You might have to use `sudo`:

```bash
dpkg --get-selections | sudo tee /var/log/packages.log
```

Note that `sudo` is used before `tee` instead of at the beginning of the
command (`sudo dpkg...`). If we used it at the beginning, `sudo` would be
"lost" to the pipe (`|`) symbol.

***NOTE THAT BY DEFAULT `tee` OVERWRITES FILES***. Use `-a` to append to files
instead:

```bash
ls | tee -a file.txt
```

This way, you can keep appending to a log file.
