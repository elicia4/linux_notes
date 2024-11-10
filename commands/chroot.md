# `chroot`

[***Table of Contents***](/README.md)

You can use this command to run programs with a different root directory:

```bash
sudo chroot /the/chroot/path my-fun-program
```

It's the simplest and earliest form of container software. It dates back to
Unix v7 (it ran on [PDP-11] in 1979 (https://en.wikipedia.org/wiki/PDP-11)).

If you create a temporary directory...:

```bash
mkdir /tmp/my-example-chroot
```

...you can try to set up an isolated self-contained `chroot` environment:

```bash
cd /tmp/my-example-chroot # move to that directory
mkdir bin lib64 lib # create system folders
cp -v /bin/{bash,ls} bin/ # make a copy of `bash` and `ls` programs
sudo chroot /tmp/my-example-chroot/ # try this running this chroot environment
```

^It won't work (yet). Use `ldd` to find the dependencies of `bash` and `ls` and copy them into the `chroot` environment:

```bash
cp -v /usr/lib64/ld-linux-x86-64.so.2 lib64
cp -v /usr/lib/{libcap.so.2,libc.so.6,libncursesw.so.6,libreadline.so.8} lib
```

Now it should work!

```bash
sudo chroot /tmp/my-example-chroot/ # try running it again
```

It only contains `ls` and bash programs, so it isn't very useful. 

The primary usage of `chroot` is for creating cross-compilers, OS development
and other non-security related isolation tasks.
