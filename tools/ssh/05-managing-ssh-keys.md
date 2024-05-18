# Managing SSH Keys

[***Table of Contents***](./README.md)  

Imagine there are multiple servers you have to manage. For each new server you
should create a new key pair. Having a separate key *per server* is usually a
good idea, but you have to be careful to specify the key whenever you connect
to a new server because if you have too many keys you might get locked out of
the server, since it's going to try each one of the keys when you connect.

So what do you do? Generate an SSH key that is specific to that client:

```bash
ssh-keygen -t ed25519 -C "acme"
```

- `-t ed25519` is a different type of key, it is more secure than the default
`rsa`.  It will also have a much shorter public key, which supposedly makes it
easier to manage. 
`-C "acme"` is a comment, `acme` is the username the key pair is created for.
Next, you can name the key differently. Name it to match its purpose for
example: `/home/jay/.ssh/acme_id_ed25519`. It doesn't really matter what you
name the key, just make sure its name is clear and indicates what it unlocks.
Then create a passphrase, *it is* necessary.

Take a look at your new key. At the end of it, there will be a comment *you*
created. By default, the comment is `<your_username>@<your_computer>`.

To push your key to a remote server:

```bash
ssh-copy-id -i ~/.ssh/acme_id_ed25519.pub <username>@<IP>
```

Now that you have a key specific to the server, how would you differentiate
the key you want to use for an SSH connection? You can specify it with `-i`:

```bash
ssh -i ~/.ssh/acme_id_ed25519 <username>@<IP>
```

- `-i <path>` - path to the private key, not the public one.  

### Passphrase Automation

Typing in your passphrase every time you want to log in is annoying. You can
use the `ssh-agent` to cache the key in memory so that you only need to enter
the passphrase once and then the key is unlocked for every single connection
thereafter until you close the terminal window. 

On Ubuntu Desktop `ssh-agent` is enabled by default. On the server it's not.
See if the process named `ssh-agent` is running (don't confuse it with `grep`):

```bash
ps aux | grep ssh-agent
```

To actually start it on a server:

```bash
eval "$(ssh-agent)"
```

If you were to disconnect from the terminal, the `ssh-agent` would be gone. To
add the key to the `ssh-agent`:

```bash
ssh-add ~/.ssh/acme_id_ed25519
```

Next time you log in, you won't need to enter the passphrase!

[***Next Note***](./06-configuring-ssh-server.md)
