# Write Images to USB Drives with `USBImager`

[***Table of Contents***](/README.md)

USBImager is a simple lightweight cross-platform *GUI* tool for all your image
to USB writing needs. Check it out at
[https://gitlab.com/bztsrc/usbimager/](https://gitlab.com/bztsrc/usbimager/).

Manual installation instructions are provided on the GitLab page. Note that
some dependencies are needed, but you most likely already have them installed
on your machine. To install on Arch from AUR:

```bash
# install dependencies
pacman -S gtk3 udisks2
# install the package from AUR
yay -S usbimager-bin
```

Launch it!

```bash
usbimager
```

The UI is intuitive and pretty self-explanatory. To write an image to a device:
1. Select an image in the first field and the device (the flash drive) in the
   second field. 
1. *Make sure you have everything backed up on your flash drive before writing
   because the installation process will wipe everything from it*. 
1. The `Verify` option instructs the program to verify that the process
   completed successfully.
1. Click on `Write` in the 2nd row.

You can also create a backup image file from a device:
1. Select a device in the 3rd row.
1. The `Compress` option compresses the image using ZStandard.
1. The image file will be saved on your Desktop, its name is in the 1st row.
   (On Linux,`~/Desktop` is used by default, if it doesn't exist `~/Downloads`
   is used)
