# CD Image Creation

[***Table of Contents***](/README.md)

Optical disks support three recording types:
- read-only (*CD or compact disc* and *CD-ROM or compact disc read-only
  memory*)
- recordable (but you can write only *once*, *CD-R or compact disc-recordable*)
- re-recordable (or rewritable, *CD-RW or compact disc-rewritable*)

To write to a CD you need to do the following things:
1. Create an ISO image file that is the exact file system image of the CD-ROM
1. Write the image file onto the disc

To make ISO image of an existing CD, use `dd`:

    dd if=<cd-device-name> of=<iso-name>.iso

    # for example
    dd if=/dev/cdrom of=distro.iso

This works for data DVD's as well, but won't work for audio CDs since those do
not use a file system for storage. For audio CDs, refer to `cdrdao`.

To create an image out of files in the "cd-files" directory:

    genisoimage -o <iso-name>.iso -R -J ~/cd-files

- the `-R` option adds metadata for the *Rock Ridge extensions* that allows the
  use of long filenames and POSIX-style file permissions
- the `-J` option enables the *Joliet extensions*, which permit long filenames
  for Windows

You can mount an ISO image:

    mkdir /mnt/iso_image
    mount -t iso9660 -o loop image.iso /mnt/iso_image

Unmount it after you no longer need it:

    umount /mnt/iso_image

After you have an image file, you can burn it (write it) to your CDs. If you
have a CD-RW (rewritable, *not recordable or CD-R*), it needs to be erased or
*blanked* first. Use `wodim` for that:

    wodim /dev/cdrw blank=fast

We specified the type of blanking as well, the fastest one is the "fast" type.

To write an image:

    wodim -v dev=/dev/cdrw image.iso

- `-v` is for verbose
- `-dao` writes the disc in the *disc-at-once* mode, it's used for commercial
  repoduction. The default mode is *track-at-once*, which is useful for
  recording music tracks.

Sometimes a distributor of an ISO-image, like a distrubution, provides a
*checksum*, a number that uniquely represents the contents of a file, to verify
the integrity of an ISO image. If the contents of a file change by *one* bit,
the checksum will be different. To generate the checksum of a file:

    md5sum image.iso

After you get it, compare the string to the one provided by the distributor.

You can verify newly written media the same way, check the checksum of the
image file and then calculate the checksum for the media.

To verify the media we have to limit the calculation to only the portion of the
optical media that contains the image. We do this by determining the number of
2,048-byte blocks the image contains (optical media is always written in
2,048-byte blocks) and reading that many blocks from the media. For that reason
we set the block size to 2048 (`bs=2048`) and set count (`count=...`) to the
filesize divided by 2048:

    md5sum /dev/cdrom
    md5sum image.iso; dd if=/dev/cdrom bs=2048 count=$(( $(stat -c "%s" \
    image.iso) / 2048 )) | md5sum

- `bs=` = block size
- `count=` - copy only N input blocks
- `stat -c "%s"` displays the image size in bytes

The result of `stat` is then divided by 2048 and set to `count`, and then the
checksum is calculated. Since we didn't specify the `of` parameter, the result
will be printed to standard output, in this case piped to `md5sum`.
