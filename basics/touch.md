# `touch`

`touch` creates a file if the argument doesn't exist in the current directory:

```bash
touch filename
ls -l filename
```

You can create/update multiple files at once:

```bash
touch file1 file2 ...
```

If it does exist, it updates its access and modification times to the current
time:

```bash
touch filename
ls -l filename
```

`-a` to change only the access time:

```bash
touch -a filename
```

Some programs (like `make`) change their behavior based on the last-modified
timestamps of files.

`-c` to not create a file if argument doesn't exist:

```bash
rm filename
touch -c filename
ls -l filename
```
