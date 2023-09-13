# Public Key Authentication

Notes on the video "Linux Crash Course - Public Key Authentication" by
LearnLinuxTV.

[***go back to README***](/README.md)  

Disclaimer: This has a lot of useful Windows info (hopefully you will never
need it).

OpenSSH is the standard of remote server management.

You really shouldn't be using passwords for authentication. You should set up
public key authentication.

To make sure `ssh` is installed (on both MacOS and Linux distros):

    which ssh

On Windows, the ssh-client isn't installed by default. There are many methods,
but the most widespread one is using PuTTY. Go to [putty.org](putty.org) and
download and install PuTTY, grab the latest installer (64-bit x86). There's
nothing special to its installer, just click through it like usual. The app you
need is called PuTTY.

To generate an SSH keypair (the same process for both Mac and Linux). Make sure
you don't already have an SSH keypair on your system, after executing the
command whatever keypair located in the default location will be deleted:

    ls -l ~/.ssh

If it's empty, you're good. To generate the keypair:

    ssh-keygen -b 4096

The `-b` option specifies the bit size, `4096` is a lot stronger than the
default. The prompts are self-explanatory, a passphrase is recommended. That's
it.

You now have two files, one with a `.pub` extension, you can show it to
anybody, that's your *public* key, the other one is the private key, **don't**
show it to anyone.

Now you have to add your key to your server. Test connectivity first:

    ssh username@ip-address

Enter `yes` in the prompt, then enter the password. You should be in. `CTRL+D`
to disconnect. Now copy the public key:

    ssh-copy-id user@ip

It should now be on the server.

If you now list the `.ssh` directory on the remote server, you should see a new
`authorized_keys` file there. It just got created, it hadn't been there before
you moved the public key. View it:

    cat authorized_keys

It should contain the contents of your public key.

### Windows keypair generation (this is beyond insane)

You will not believe it, but you can do in on Windows too. Start up PuTTY.
Enter the `user@ip` inside the `Host Name (or IP address)` field. Give it a
name inside the `Saved Sessions` field, then press `Save`. Now your session is
saved, you can `Load` it any time you want.

To create an SSH key pair, open `PuTTYgen`, it should be inside the PuTTY
directory. Change the bit size to 4096 in the bottom right field and click
`Generate`. Then move your cursor around in the empty part of the window to
create additional entropy. It should have generated a key. Right click into the
text field, click `Select All`, then right click again and click `Copy`, then
save the text into a text file. 

These steps are not necessary, this is just how it was done in the video. I
guess people usually save the file inside the `Documents` folder. Create an
empty `ssh keys` folder inside and store it there. Call it `public key`, save
it as `All Files (*.*)`. Save the private key as well by clicking `Save private
key`, generate a passphrase if you want.

Open the server in PuTTY, open the `authorized_keys` file, paste the contents
of the public key inside the file (`Shift + Insert`). Now close the session, 
reopen PuTTY, under `Connection>SSH>Auth` `Browse...` for the private key, it
has the `.ppk` extension. Go back to `Session` and log in. 

That's it.
