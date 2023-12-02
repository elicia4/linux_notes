### Using Public-Private Keys

[***Table of Contents***](README.md)  

SSH keys allow you even greater security and convenience. To connect to a
server you have to type the password. 

OpenSSH is very secure, but if your password is weak an attacker will easily
get into your server. It would be a lot better without passwords at all, SSH
keys allow you to avoid typing the password and use the key to connect.

If you fail the key or don't have the key, it will still ask you for the
password. You can disable password authentication. Disabling passwords and
using SSH keys is the recommended security approach. This way any sort of
password guessing is out of the question. If you don't have the key, you can't
get in!

You can generate a brand new key, make sure you don't already have a key in the
directory you want to create your key:

    ssh-keygen

If you do have the key in the directory already, it will be overwritten and you
might lose access to some server. Then enter in the passphrase. It is very
important, you might think it's defeating the purpose of having a key, but the
passphrase is just another added layer of security that makes it so you need to
know that passphrase to begin using that key, and that passphrase is something
you type locally, not on the server end, which means if someone steals that key
they won't be able to use it. Always use it. 

Enter the key again, now you have two files: `id_rsa` and `id_rsa.pub`, the key
fingerprint and the key's randomart image.  NEVER LEAK THE PRIVATE KEY
(`id_rsa`). You can show the public key (`id_rsa.pub`) wherever you want. It's
meant to be public.

Now, to actually use the keys you will have to copy the public key to the
remote server. Copy the public key:

    cat id_rsa.pub 

Then SSH into your server. Create the `.ssh` folder if it doesn't exist. Create
an `authorized_keys` file inside it and paste the key inside it:

    mkdir .ssh 
    vim authorized_keys

Relog into the server. You didn't have to put in the password! The server
checked your private key against the public key on the remote end and
mathematically linked them. If they are a successful match, you will be
connected. This is why it's not a problem to leak out the public key. The
connection is verified against a private key, which stays with you and stays
secret. To check exactly what happened when you connected:

    ssh -v root@<IP>

Check the box to always have the key unlock every time you log in.

The easy way to add a key to the remote server:

    ssh-copy-id -i ~/.ssh/id_rsa.pub root@<IP>

The `-i` parameter is for input file. The command will create both the `.ssh`
directory and the `authorized_keys` file, as well as populate the file with the
key.

[***Go to Next Note***](05-managing-ssh-keys.md)
