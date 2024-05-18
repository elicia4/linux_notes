# The `scp` Command

Notes taken on [this video](https://youtu.be/Aa7tKMmeFZI) by LearnLinuxTV.

[***Table of Contents***](/README.md)  

You can transfer files between servers with the `scp` command. It stands for
"secure copy". 

The `rsync` command does essentially the same thing, if you intend to transfer
a large number of files use `rsync`, if you only want to send one use `scp`. To
see if `scp` is available on your system:

```bash
command -v scp
```

The first thing to know about `scp` is that it uses `ssh`, the delivery
mechanism through which files are transferred. That means that having another
server is a prerequisite to `scp`. Make sure you can `ssh` into that server.

To copy a file from a local location to a remote server:

```bash
scp file-name target-server:target-directory
```

For example:

```bash
scp sshd_config_custom dev:/home/user/
```

To check the file on the server, `ssh` into it and `ls` the target directory.

The command works in reverse as well, so you can copy a file from a remote
location to a local one:

```bash
scp dev:/home/user/sshd_config_custom /home/user/
```

To check, use `ls`. 

Quick SSH tip: if you want to run a single command on a server, use this:

```bash
ssh <destination> <command>
```

For example:

```bash
ssh dev ls
```

You can also simplify the `scp` command, imagine you have the following
command:

```bash
scp file dev:/home/user/
```

If a target uses *your user's* name, the home directory will be implied:

```bash
scp file dev:
```

Notice that the username is omitted as well. By default it uses yours, but you
can also specify:

```bash
scp file admin@dev:
```

If the path you need includes a subdirectory of your home directory:

```bash
scp file dev:Downloads
```

To copy a directory:

```bash
scp -r dir-name dev:
```

The `-p` option will retain the modification date of the files you copy over:

```bash
scp -pr dir-name dev:
```

`-p` stands for "preserve".

You can also specify a port with the `-P` option. By default it will use 22,
the default SSH port:

```bash
scp -P 2222 file dev:
```

Do not use `2222`, it`s too widely used already. (:
