# Linux Logical Volume Manager (LVM)

Notes taken on the "Linux Logical Volume Manager (LVM) Deep Dive Tutorial"
video by LearnLinuxTV.

[***go back to README***](/README.md)

### Why LVM?

LVM is a great idea especially on servers. If you don't have LVM on a server
and the disk space fills up (because of a huge log file for example), you won't
be able to do much, this happens often. If you had LVM, you could grow your
system to give it some additional space. You could `truncate -s 0` your log
files or `gzip` them thus freeing up some space, but what if you weren't
allowed to do that? 

### LVM Demo

What if this happened and you had LVM on your system? To show available space:

    df -h

You will have a different `Filesystem` in the root field, regularly it would be
`/dev/sda1` or something, on a system with LVM it would be something like
`/dev/mapper/vg_ubuntu-lv_root`. `vg_ubuntu` is "volume group", `lv_root` is
the root logical volume.

To recover with LVM you can increase the size of the filesystem:

    lvextend --resizefs -l +100%FREE /dev/mapper/vg_ubuntu-lv_root

You just added some space to your filesystem, thus fixing the problem, WITHOUT
restarting the server. You should always set up LVM on your server. Worst case
scenario, you will never use it, never even remember that it's there, but if
you ever want to benefit from LVM, you'll wish that you had it set up.

#### LVM Layout

Let's see what parts LVM consists of.

1. *Physical volumes* (physical/virtual hard drives) make up a volume group. A
   physical volume is a hard drive that was initialized to be an LVM physical
   volume.
1. A *volume group* is a container for logical volumes.
1. You can have a *logical volume* for `/`, for `/var` etc.
1. Logical volumes are formatted with a *file system*, for example `ext4`. That
   allows Linux to work with them as it would work with any other `ext4`
   formatted hard drive.

For example, imagine you have two 16GB hard drives, with LVM you can have a
what is seen as a 32GB hard drive. Your logical volumes will be the same size,
*but you can expand them*.

### Installing Ubuntu Server (With LVM)    

Create a new VM with a Ubuntu ISO. 

When you get to the `Guided storage configuration` page, you want to manually
dedicate the amount of space to LVM, so choose `Custom storage layout`. 

1. Select your disk, select `Use As Boot Device`.
1. Select `Add GPT Partition`.
1. Create one 1G, ext4 `/boot` partition.
1. Add a new GPT partition, set its `Format:` to `Leave unformatted`.
1. `Create volume group (LVM)`, name it `vg-ubuntu`, select the volume(s) you
   want to add to the group.
1. Select your volume group, select `Create Logical Volume`. Create a logical
   volume for root, name it `lv-root`, leave some place on the disk.

You're done.

### LVM info commands

Run `lsblk` to see your partitions: 
    
    lsblk

Note the name and the mountpoint.

To give information about the physical volume:

    sudo pvdisplay

To display information about the volume group:

    sudo vgdisplay

To display logical volume information:

    sudo lvdisplay

To see where logical volumes are mounted:

    df -h 

Or:

    cat /etc/fstab

### Expanding a Filesystem

What if you don't have any space left? Install another hard drive. To confirm:

    lsblk

Turn a second hard drive into a physical volume, **be very careful here**, if
you attach the wrong hard drive here, you are wiping out your entire
filesystem:

    sudo pvcreate /dev/<hard-drive>

To confirm:

    sudo pvdisplay

As you can see, it's not a part of any volume group. To add it to a VG:

    sudo vgextend <volume-group> <physical-volume>

Look at the free space:

    df -h # it's not there yet

See VG info:

    sudo vgdisplay

You should have some unallocated space.

To extend a logical volume:

    sudo lvextend -L +2G /dev/mapper/vg--ubuntu-lv--root

Now see the magic:

    df -h

...and it's the same, nothing has changed. You have to resize the filesystem so
that it can use the available space:

    sudo resize2fs /dev/mapper/vg--ubuntu-lv--root

Check the space:

    df -h

It is done!

Let's give it the rest of the space:

    sudo lvextend --resizefs -l +100%FREE /dev/mapper/vg--ubuntu-lv--root

The `--resizefs` option automatically resizes the filesystem. Run:

    df -h

You have extended your volume even further. You were able to do it online,
without the need to restart the server.

Just for practice, add another volume to your server:

    lsblk;
    sudo pvcreate /dev/<hard-drive>

Now create a new volume group:

    sudo vgcreate <name> /dev/<hard-drive>

Display volume groups:

    sudo vgdisplay

As you can see, `Alloc PE / Size` is `0 / 0`, all of it is free. Create a new
logical volume:

    sudo lvcreate <vg_name> -L 5G -n lv_logs

`-n` names the logical volume. Show logical volumes:

    sudo lvdisplay

Format it so that you can use it:

    sudo mkfs.ext4 /dev/mapper/vg_extra-lv_logs;
    df -h

As you can see, it's not there yet. You have to mount the new logical volume
first:

    sudo mkdir -p /mnt/extra/logs;
    sudo mount /dev/mapper/vg_extra-lv_logs /mnt/extra/logs;
    df -h

As you can see, it's mounted now. You also want to make sure that this logical
volume is automatically mounted whenever you boot the system:

    blkid /dev/mapper/vg_extra-lv_logs

Copy the UUID (universally unique identifier). You can use the path itself, it
shouldn't matter. Back up the `fstab` file first:

    sudo cp /etc/fstab /etc/fstab.bak

Now unmount the `logs`:

    umount /mnt/extra/logs

Now edit the `fstab` file:

    sudo vim /etc/fstab;

Add the following line:

    UUID=<uuid you copied> /mnt/extra/logs ext4 defaults 0 2 

The last number indicates the priority during the filesystem check. Now test
the `fstab` file, DON'T reboot the machine before you've tested it:

    sudo mount -a

Check the mounted volumes:

    df -h

### LVM Snapshots

Create a new logical volume:

    sudo lvcreate vg_extra -L 1G -n lv_web

Format it:

    sudo mkfs.ext4 /dev/mapper/vg_extra-lv_web

Do the `fstab` drill:

    sudo cp /etc/fstab /etc/fstab.bk

`blkid`:

    sudo blkid /dev/mapper/vg_extra-lv_web # copy the UUID

Add the line to `fstab`:

    UUID=<your UUID> /mnt/extra/web ext4 defaults 0 2

Create the directory:
    
    sudo mkdir -p /mnt/extra/web

Mount everything:

    mount -a

Check that it's mounted:

    df -h 

To explain snapshots, create a new file on a new volume:

    sudo echo "LVM IS GREAT" > /mnt/extra/web/important_file.txt

To create a snapshot, make sure you have unclaimed space:

    sudo lvcreate /dev/mapper/vg_extra-lv_web -L 1G -s -n web_snapshot_20230101

`-s` indicates that it's a snapshot.

View your logical volumes:

    sudo lvs

You should have a snapshot on the list, it has `lv_web` `Origin`, the
percentage of data used (`Data%`). It should not get to 100%, don't use
snapshots as backups. You can test changes and in case something breaks restore
back to a previously created snapshot.

Delete `important_file.txt`. To restore to a snapshot, there are multiple
options. Create a temporary directory to mount the snapshot to:
    
    sudo mkdir /mnt/extra/snapshot
    sudo mount /dev/mapper/vg_extra-web_snapshot_20230101 /mnt/extra/snapshot

Now you should have the snapshot mounted. You can simply copy the file from the
snapshot to its location on the filesystem.

You can also fully recover a logical volume from a snapshot, restore it:

    sudo umount /mnt/extra/web;
    df -h; # it's not mounted anymore
    sudo lvconvert --merge /dev/mapper/vg_extra-web_snapshot_20230101 

The origin is set to the original logical volume, this should overwrite the
original. Re-activate the logical volume:

    sudo lvchange -an /dev/mapper/vg_extra-lv_web # it's deactivated
    sudo lvchange -ay /dev/mapper/vg_extra-lv_web # it's reactivated

Now everything should be flushed. Re-mount it:

    mount -a;
    df -h;
    ls -l /mnt/extra/web

The `important_file.txt` should be there.

Play around with LVM on a test system before you put it in production.
