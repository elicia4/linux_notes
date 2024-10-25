# The `mv` command

[***Table of Contents***](/README.md)

`mv` is used to move or rename files. After it's used, the original filename no
longer exists after the operation. It's used like so:
    
```bash
mv item1 item2
```

To move items to a directory:

```bash
mv item ... directory
```

`-n` to prevent files from overwriting others:

```bash
mv -n item item2
```

E.g.:

```bash
# create 2 files. output file & dir contents
echo file1 > example_1.txt; echo file2 > example_2.txt
ls; cat example_1.txt example_2.txt
# try to overwrite a file with -n. output file & dir contents
mv -n example_1.txt example_2.txt
ls; cat example_1.txt example_2.txt
# try to overwrite a file with -n. output file & dir contents
mv example_1.txt example_2.txt
ls; cat example_1.txt example_2.txt
# remove example files
rm example_1.txt example_2.txt; ls
```

`mv` options are similar to `cp` and `rm` ones:

- `-i` prompts the user for confirmation before overwriting an existing file.
  If this option is not specified, `mv` will silently overwrite files. 
- `-u` only moves files that don't exist/are newer than the existing
  corresponding files in the destination directory.
- `-v` displays informative messages as the move is performed.
