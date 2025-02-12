# `patch`

[***Table of Contents***](/README.md)

`patch` is used to apply changes to files, more precisely to apply a diff file
or the output of `diff` to a file.

Diff files are incredibly useful when working on large projects with millions
of lines. Instead of sending over an entire project over to another user,
`diff` files can be sent, which are usually a lot smaller. Diff files can then
be applied to projects with `patch`.

Another advantage of a `diff` file aside from its size is their format. They
can easily show the changes made to a file, allowing for faster review.

To prepare a diff file for use with `patch`:

```bash
diff -u old_file new_file > diff_file.diff
```

When working with directories, it's a good idea to use `-Naur`.

Changes will be applied to the *old* file. To apply it:

```bash
patch < diff_file.diff
```

Another way to patch:

```bash
patch /path/to/old_file /path/to/diff_file.diff
```

To reverse the change (undo the patch):

```bash
patch -R < diff_file.diff
```

There was no need to specify target files since the unified format already
contains the filenames in the header.

If you make changes to the old file and apply the patch, it might work, it
might not. It depends on how much has been changed in the old file. `patch`
will attempt to do the changes and give a detailed output on how it went and
what was changed.

The failed changes will be saved to a `<old_file>.rej` file.

If some of the changes (called 'hunks' in the `patch` output) succeed and some
fail, things can get a little messy. So in addition to the `.rej` file, a copy
of the original file is created with an `.orig` suffix.

`patch` and `diff` are incredibly useful for making changes to files. You can
easily send these small `diff` files over to other machines without an issue.

See more details:

```bash
man diff
man patch
```
