# The `mv` command

[***Table of Contents***](/README.md)

`mv` is used to move or rename files. After it's used, the original filename no
longer exists after the operation. It's used like so:
    
    mv item1 item2

To move items to a directory:

    mv item ... directory

The options `mv` has are similiar to those of `cp` and `rm`:

- `-i` prompts the user for confirmation before overwriting an existing file.
  If this option is not specified, `mv` will silently overwrite files. 
- `-u` only moves files that either don't exist or are newer than the existing
  corresponding files in the destination directory when moving files from one
  directory to another.
- `-v` displays informative messages as the move is performed.
