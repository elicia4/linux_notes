# `whoami`

[***Table of Contents***](/README.md)

The command prints the current user:

```bash
whoami
```

If you use `sudo` to become a different user, `whoami` will show that user:

```bash
sudo -u postgres whoami
```

It's very useful for writing automated scripts. E.g., to run the following
command...:

```bash
fdisk -l /dev/sda
```

...you need to be `root`. You can check the current user before running the
command:

```bash
#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    fdisk -l /dev/sda
else
    echo "Must be root."
fi
```

The command runs if the user is `root`, otherwise a message appears.
