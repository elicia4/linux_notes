# `realpath`

[***Table of Contents***](/README.md)

It finds the unique representation of a file/directory path (resolved absolute
file path):

```bash
cd ~
mktemp -p . # get the name of the file
realpath <file>
realpath ./././<file>
```

If you use different paths that refer to the same file in the same location,
you will get the same result, the original simplified file path.

If you create a symlink to the file and use `realpath` you will get that same
path:

```bash
ln -s <file> <file_link>
realpath <file_link>
```

`-e` and `-m` control what happens if a path component doesn't exist:
- `-e` - all components of the path must exist
- `-m` - no path components need exist or be a directory

Let's say there's no file called "doesnt_exist.txt" in the current directory.
If you call `realpath`, the path will still be displayed as if it did:

```bash
realpath doesnt_exist.txt
```

But if you call it with `-e`, the program will check if the file exists first:

```bash
realpath -e doesnt_exist.txt
```

This is not the case for files in directories in the current directory. If you
specify file inside a directory that doesn't exist ("not_exist" in the example
below), `realpath` will throw an error:

```bash
realpath not_exist/file_new_not_exist.txt
```

`-m` flag will output the paths even if the directory/file structure doesn't
exist:

```bash
realpath -m not_exist/file_new_not_exist.txt
```

`-P`, `-L` and `-s` that control how symlinks and relative path components are
resolved:
- `-P` - resolve symlinks as encountered
- `-L` - resolve '..' components before symlinks
- `-s` - don't expand symlinks

Set up a simple file structure to test these:

```bash
mkdir -p let_fail/other
touch let_fail/{svb,lehman}.txt
ln -s let_fail/svb.txt failed-bank.txt
ln -s let_fail/other worst
ln -s lehman.txt let_fail/failed-bank.txt
```

`-P` resolves symlinks as encountered (default):

```bash
realpath -P worst/../failed-bank.txt 
```

You should've gotten `<absolute_path>/let_fail/lehman.txt`, the absolute path
to the actual file, all symlinks resolved.

`-L` resolves '..' components before symlinks:

```bash
realpath -L worst/../failed-bank.txt 
```

If this is not clear, try:

```bash
realpath -L worst/../
```

`worst/../` is resolved to `<absolute_path>/test_path_dir`, because `worst`
doesn't get resolved. This path is resolved as the directory "above" `worst`,
which is `<absolute_path>/test_path_dir`.

`-s` doesn't expand symlinks:

```bash
realpath -s worst/../failed-bank.txt 
```

You should've gotten `<absolute_path>/failed-bank.txt`, since all of the links
are treated as regular files with this option.

You can also use the `--relative-to` argument to obtain a path that's relative
to the specified directory:

```bash
realpath --relative-to=$HOME failed-bank.txt
```
