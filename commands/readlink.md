# `readlink`

[***Table of Contents***](/README.md)

It's used to canonicalize a file/directory path. If you run it on a symbolic
link, you'll see the target that the symbolic link points to:

```bash
readlink link_file.txt
echo $?
```

The return code will indicate success.

If you run it on a regular file, you won't see any output and the return code
will indicate failure:

```bash
readlink regular.txt
echo $?
```

By default, the command runs in a so-called 'readlink mode'. It's intended to
run only on symbolic links and will return an error code otherwise.

However, it supports other flags that activate 'canonicalize mode'. It prints
absolute file paths. It's activated by `-f`, `-e`, and `-m` flags. It behaves
exactly like `realpath`.

Let's say there's no file called "doesnt_exist.txt" in the current directory.
If you call `readlink`, the path will still be displayed as if it did:

```bash
readlink -f doesnt_exist.txt
```

But if you call it with `-e`, the program will check if the file exists first:

```bash
readlink -e doesnt_exist.txt
```

This is not the case for files in directories in the current directory. If you
specify file inside a directory that doesn't exist ("not_exist" in the example
below), `readlink` will throw an error:

```bash
readlink -f not_exist/file_new_not_exist.txt
```

`-m` flag will output the paths even if the directory/file structure doesn't
exist:

```bash
readlink -m not_exist/file_new_not_exist.txt
```

According to `readlink`'s own documentation, `realpath` is preferred over
`readlink` for canonicalization of file paths.
