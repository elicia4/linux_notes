# `id`

[***Table of Contents***](/README.md)

Print user and group information for user(s):

```bash
id
```

It lists all of the ID values that represent users and groups on your system.
By default, it shows the current user's ID information and all of the groups
the current user belongs to.

These values can also be found in `/etc/passwd`.

The group ID's can be found in the `/etc/group` file.

You can also specify a user to `id` to see information only for that user:

```bash
id postgres
```

To get the effective user ID (UID) of a user:

```bash
id -u <user>
```


To get the effective group ID of a user:

```bash
id -g <user>
```

To get the IDs of groups a user belongs to:

```bash
id -G <user>
```

To get the username of the (current by default) user:

```bash
id -un <user>
```

To get the real UID of a user:

```bash
id -ru <user>
```

If you make a copy of `id` executable and enable the SETUID bit while also
changing the file ownership, then you will be able to observe the difference
between the effective UID and the real UID:

```bash
cp /usr/bin/id ./id-copy
ls -l
sudo chown postgres:postgres id-copy
sudo chmod u+s id-copy
./id-copy -ru
./id-copy -u
```

When setuid is applied to an executable file, it sets the effective UID
from that of the real user (the user actually running the program) to that of
the program's owner.
