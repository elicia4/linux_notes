# Group Management

Notes on the video "Linux Crash Course - Managing Groups" by LearnLinuxTV.

[***Table of Contents***](/README.md)  

Every file is owned by a user and group:
    
    ls -l

To find out which group a user is a member of:

    groups [user]

Groups by itself will show current user's groups. There's a file similiar to
`/etc/passwd` but group-related called `/etc/group`. The columns mean:

1. Name
2. Group password (nobody uses them and nobody should)
1. Group ID (GID)
1. Users that are members of that group

To create a group:

    sudo groupadd group-name

To delete a group:

    sudo groupdel group-name

There are two types of groups:
1. Primary
2. Supplementary aka secondary

The GID next to an username in `/etc/passwd` indicates the primary group for
the user.

What's the difference between a primary and a secondary group? None. A group is
only a primary group if it's assigned to a user as a primary group, it's all
about how it's assigned. In terms of impact to a user, the files they will
create will be owned by their primary group. A user can be a member of just one
primary group and many many secondary groups.

To add a user to a secondary group:

    sudo usermod -aG group-name username # usermod is not specific to groups     
    # a = append, G = secondary groups

To **change** a user's primary group:

    sudo usermod -g group-name username

After changing a user's group relog.

There's an alternative command to `usermod`:

    sudo gpasswd -a username group-name

To allow users to use `ssh`:

    vim /etc/ssh/sshd_config

Add a new option:

    AllowUsers user1 user2 user3 # define users that are allowed to access ssh

After you restart the `sshd` service, this will work. This is a bit painful to
manage, imagine you had 200 users here instead of 3. You can change it to:

    AllowGroups group1

To remove a user from a group:

    sudo gpasswd -d username group-name


