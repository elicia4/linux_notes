# The `rm` command

[***go back to README***](/README.md)

The `rm` is used to remove files or directories:

    rm item ...

***WARNING***: Incorrect use of `rm` can be devastating. Whenever you use
wildcards with `rm`, test the wildcard first with `ls`. This will let you see
the files that will be deleted.

The options of `rm` are similar to those of `cp` and `mv`:

- `-i` prompts the user for confirmation before deleting an existing file. If
  this option is not specified, `rm` will **silently** delete files. When
  working with sensetive data, remember to use this option.
- `-r` recursively deletes directories. This means that if a directory being
  deleted has subdirectories, delete them too. To delete a directory, this
  option must be specified.
- `-f` ignores nonexistent files and does not prompt. This overrides the `-i`
  option. 
- `-v` displays informative messages as the deletion is performed.
