# `touch`

`touch` creates a file if the argument doesn't exist in the current directory:

```bash
touch filename
ls -l filename
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

`-c` to not create a file if argument doesn't exist:

```bash
rm filename
touch -c filename
ls -l filename
```
