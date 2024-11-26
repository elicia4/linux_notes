# `sync`

[***Table of Contents***](/README.md)

It can be used to ensure that any cached writes are committed to persistent
storage:

```bash
sync
```

Say you have an important piece of data that you want to back up to an external
hard drive:

```bash
cp my_data.zip /external-drive/my_data.zip # you no longer have control over the shell session
# in another shell session
watch ls -l /external-drive # see how the file is growing
```

Eventually, after the file is copied, the command prompt should come back in
the first shell session. If you decide to unplug your hard drive now, you data
may be corrupted because of cached writes: 

```
ls -l /external-drive/my_data.zip # the file size may be smaller
md5sum /external-drive/my_data.zip # checksum doesn't match
```

These indicate that the backup is corrupt. This is exactly the reason why
`sync` is useful. You should use it even if the drive activity light has
stopped flashing:

```bash
sync
```

Now the file size and checksum should match.
