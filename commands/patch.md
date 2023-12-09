# The `patch` command

[***Table of Contents***](/README.md)

The `patch` program is used to apply changes to files, more precisely to apply
a diff file or the output of `diff` to a file.

Diff files are incredibly useful when working on large projects with millions
of lines. Instead of sending over an entire project over to another user, diff
files can be sent, which are obviously usually a lot smaller. Diff files can
then be applied to projects with `patch`.

Another advantage of a diff file aside from its size is their format. They can
easily show the changes made to a file, allowing for faster review.

To prepare a diff file for use with `patch`:

    diff -Naur old_file new_file > diff_file.txt

To apply it:

    patch < diff_file.txt

There was no need to specify target files since the unified format already
contains the filesnames in the header.

Another way to patch:

    patch /path/to/old_file /path/to/diff_file.txt
