# `rmdir`

[***Table of Contents***](/README.md)

Deletes empty directories:

```bash
mkdir new_empty_xd
ls -l new_empty_xd
rmdir new_empty_xd
ls -l new_empty_xd
```

If a provided directory contains anything, `rmdir` will produce an error
message:

```bash
mkdir new_empty_xd
touch new_empty_xd/file
ls -l new_empty_xd
rmdir new_empty_xd
# rmdir: failed to remove 'new_empty_xd': Directory not empty
```

If you delete the file first, so that the directory is empty, `rmdir` will
delete the folder for you:

```bash
rm new_empty_xd/file
rmdir new_empty_xd
ls -l new_empty_xd
```

You can delete a directory with `rm -r`, it will delete the directory and its
contents recursively. `rmdir` could be considered safer, since it forces you to
delete the contents of a folder before deleting the folder itself.

Imagine you have to delete an unused test folder, there are important
directories with the names that start the same way:

```bash
find .
# .
# ./production-data
# ./production-data-test
# ./production-data/all_customer_data.sql
rm -r production-data # autocomplete fails you here
# you had meant to delete 'production-data-test', but 'production-data' was
# deleted along with the production database. So use 'rmdir' instead!
rmdir production-data
# rmdir: failed to remove 'production-data': Directory not empty
```
