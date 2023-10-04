# SSH Overview & Setup

[**Contents**](01-intro.md)

OpenSSH is the standard when it comes to remote administration in Linux. It's 
used to connect to Linux servers to run commands, it's also what Ansible uses
for its provisioning as well.

### SSH Overview

It's important to have an understanding of what SSH does in order to use
Ansible. To connect to a remote server:

    ssh <address>

Password-based authenticatoin is the default, but it's always better to use SSH
keys to secure your connections and make it harder for someone on the outside
to break into your system.

- Make sure OpenSSH is installed on the workstation and servers. OpenSSH server
  is not installed by default on some systems:

    sudo apt install openssh-server

- Connect to each server from the workstation, answer "yes" to initial
  connection prompt

    ssh <address>

- Create an SSH key pair (with a passphrase) for your normal user account. It
  strengthens your SSH connections
    
    ls -la ~/.ssh # this is the folder where ssh keys are stored by default;
    ssh-keygen -t ed25519 -C "jay default" # -t is for type, ed25519 is more
    # secure than the default one, it's also shorter; -C is for comment;
    # Add a passphrase.

  You now have a public-private keypair. `.pub` is the public key.

- Copy that key to each server

    ssh-copy-id -i <path to pub key> <address>

  On your servers, you should be able to see it in the `~/.ssh/authorized_keys`
  file. When you connect, the server should ask you for a passphrase.

- Create an SSH key that is specific to Ansible. This one won't have a
  passphrase for automation reasons

    ssh-keygen -t ed25519 -C "ansible"
    # give it a different name, like /home/<username>/.ssh/ansible_key
    # DON'T create a passphrase

- Copy that key to each server

    ssh-copy-id -f -i <path to pub key> <address>

  Both keys should be in the `~/.ssh/authorized_keys` file. Try connecting with
  ansible key:

    ssh -i ~/.ssh/ansible-key <address>

### SSH Agent Cheat (no passphrase every time)

Do:

    eval $(ssh-agent)

`ssh-agent` is a process that can run in the background and cache your
passphrase, so that you only need to enter it once. To see that it's running:

    ps aux | grep <Agent pid>

Now you can:

    ssh-add

You should get `Identity added`. Create an alias so that the process is easier
next time:

    # ssh agent
    alias ssha='eval $(ssh-agent) && ssh-add'

Note that if you close the terminal window you also lose the alias, add to the
`.bashrc`(or whatever shell config you're using). To see that it's there:

    alias ssha
