# Group Management

Notes on the video "Linux Crash Course - Managing Groups" by LearnLinuxTV.

[***Table of Contents***](/README.md)  

`groups` lists all of the groups that a user belongs to:

```bash
groups
```

By default, they are for the current user.

Every file is owned by a user and a group:
    
```bash
ls -l
```

To output the groups a particular user belongs to:

```bash
groups [user]
# groups postgres
```

The set of groups that a user belongs to will determine if that user has the
ability to access certain files or system resources. The permission settings
related to groups can be seen with `ls -l` (5-7 symbols in the permission
string):

```bash
ls -l /dev/{input/event0,tty} /etc/shadow some-file.txt
```

The group a file belongs to is displayed in the 4th column.

There's a file similar to `/etc/passwd`, but group-related called `/etc/group`.
The columns mean:

1. Name
1. Group password (nobody uses them and nobody should)
1. Group ID (GID)
1. Users that are members of that group

To view members of a group:

```bash
grep "group-name" /etc/group
```

To create a group:

```bash
sudo groupadd group-name
```

To delete a group:

```bash
sudo groupdel group-name
```

There are two types of groups:

1. Primary
2. Supplementary (secondary)

The GID next to an username in `/etc/passwd` indicates the primary group for
the user.

What's the difference between a primary and a secondary group? None. A group is
only a primary group if it's assigned to a user as a primary group, it's all
about how it's assigned. In terms of impact to a user, the files they will
create will be owned by their primary group. A user can be a member of just one
primary group and many many secondary groups.

To add a user to a secondary group:

```bash
sudo usermod -aG group-name username # usermod is not specific to groups     
# a = append, G = secondary groups
```

To **change** a user's primary group:

```bash
sudo usermod -g group-name username
```

After changing a user's group relog.

There's an alternative command to `usermod`:

```bash
sudo gpasswd -a username group-name
```

To allow users to use `ssh`:

```bash
vim /etc/ssh/sshd_config
```

Add a new option:

```bash
AllowUsers user1 user2 user3 # define users that are allowed to access ssh
```

After you restart the `sshd` service, this will work. This is a bit painful to
manage, imagine you had 200 users here instead of 3. You can change it to:

```bash
AllowGroups group1
```

To remove a user from a group:

```bash
sudo gpasswd -d username group-name
```
