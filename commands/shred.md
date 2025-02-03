# `shred`

[***Table of Contents***](/README.md)

Overwrite files with the intention of destroying their data:

```bash
shred data.txt
```

Now, the data is overwritten with random bits:

```bash
less data.txt
```

It supports various flags. With `-s`, you can specify the number of bytes to be
shredded:

```bash
shred -s 100 data.txt # suffixes like K, M, G accepted
```

You can specify the source of random bytes with `--random-source=FILE`.

You can also deallocate and remove the file after overwriting:

```bash
shred -u data.txt
```

You can also specify exactly what to do after the file has been overwritten:

```bash
shred --remove[=HOW] file
```

HOW's (from `man shred`):
- `unlink` = use a standard unlink call  
- `wipe` = also first obfuscate bytes in the name  
- `wipesync` = also sync each obfuscated byte to the device

The default mode is `wipesync`, but note it can be expensive.

If security is an important consideration, `shred` is unlikely to be useful
when erasing files within the context of a file system.

There are many implementation details like caching and wear leveling that can
create duplicate copies of the data that `shred` won't know about.

Some of these caveats are documented in the `man` page:

```bash
man shred
```
