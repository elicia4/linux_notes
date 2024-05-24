# `cd`

`cd` allows you to change directories. You can use relative paths or absolute
paths:

```bash
cd /home/
cd ../home
```

To go to the previous directory:

```bash
cd /home
cd /usr
cd - # will change the current directory to /home
```

To go to the current user's home directory:

```bash
cd ~ # ~ is shortcut for the home dir
```

`-P` to resolve the symbolic link path before changing directory. E.g.:

```bash
ln -s /home sym_link # symbolic link sym_link points to /home
cd sym_link # you are now in /home (sym_link)
cd -P .. # you are now in /
```
