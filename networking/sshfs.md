# The `sshfs` command

Notes taken on the "Linux Crash Course Series - How to Share Files via SSHFS"
video by LearnLinuxTV.

### NOTE 
`sshfs` no longer has a maintainer, so don't use this solution for confidential
or proprietary files. SSHFS is shipped by all major Linux distributions and has
been in production use across a wide range of systems for many years. However,
at present SSHFS does not have any active, regular contributors, and there are
a number of known issues.

[***Table of Contents***](/README.md)

---

`sshfs` is a part of FUSE (Filesystem in Userspace) which aims to give the user
access to mount something without root privileges. 

`sshfs` allows you to turn `ssh` into a mount utility to mount a remote folder
locally as if it was a file share. 

On the server you will have a directory, on your local machine you will mount
that server directory.

`sshfs` is dependant on `ssh`. It allows you to mount a remote folder locally, 
the end results isn't much different from mounting an NFS or a Samba share. 

To find out if you have `sshfs`:

    command -v sshfs

If you don't have it, install it:

    sudo apt install sshfs

Check if `ssh` works by connecting to the server first:

    ssh <user>@<server>

Create a directory locally:

    mkdir remote-docs

Create a directory on the remote server:

    mkdir random-folder

Mount it:

    sshfs user@server:/home/user/random_folder remote-docs

It should now be available locally. Create some files in your locally mounted
remote directory and check if they exist on the remote server. Run:

    mount

You can see it on the bottom. As long as you have access to the remote
directory via `ssh`, you should be good to go.

To unmount the directory:

    umount remote-docs

Mount it again:

    sshfs user@server:/home/user/random_folder remote-docs

A dedicated FUSE command for unmounting the folder:

    fusermount -u remote-docs

Create an ssh key to simplify and secure the process even further:

    ssh-keygen

Set a new path so that you don't lose your existing keys. Copy your new key to
the server:

    ssh-copy-id -i ~/.ssh/new_key.pub user@server

Unmount and mount again and see what changes, the process now doesn't require a
password.

Note that `sshfs` is not a complete replacement for NFS or Samba. It's best
used for getting something done quickly, it's great for short-term uses.
    
