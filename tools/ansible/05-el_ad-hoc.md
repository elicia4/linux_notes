# Running elevated ad-hoc Commands

[**Contents**](01-intro.md)

We're going to run commands that make changes, *elevated ad-hoc commands*.

You need to use `sudo` to run these commands:

    ansible all -m apt -a update_cache=true --become --ask-become-pass

Enter the server sudo password. 

- `-m apt`: using the apt module, allows you to work with `apt` packages on a
  Debian-based system
- `-a` allows you to use an argument to that module, `update_cache=true` is the
  same thing as running `sudo apt update`, it updates the package index
- `--become` allows you to elevate privileges, by default it uses `sudo`
- `--ask-become-pass` helps us apply a password to use the `sudo` privileges

It is assumed that on each of the servers you have the same `sudo` password,
which is why it can work.

Use [ansible documentation](https://docs.ansible.com/ansible/2.8/modules/apt_module.html) 
to learn more about the `apt` module.

Let's install an actual package to all of our servers:

    ansible all -m apt -a name=vim-nox --become --ask-become-pass

- `all` you target all of your hosts
- `-m apt` using the `apt` module
- `-a` is the argument you want to give it
- `name=vim-nox` is the argument itself, it's the package you want to install
- `--become` and `--ask-become-pass` are used for `sudo` passwords

Connect to your servers and check if `vim-nox` is installed:

    ssh <host> apt search vim-nox

On the right, it should indicate that it's `[installed]`. Let's install `tmux`
as well:

    ansible all -m apt -a name=tmux --become --ask-become-pass

We want there to be changes if changes are necessary, try running the command
again:

    ansible all -m apt -a name=tmux --become --ask-become-pass

As you can see, you get `"changed": false`, that means that no changes were
made. What ansible does is bring your servers to a defined state. We'll create 
playbooks with commands that do something (e.g. users that need to be created /
packages that need to be installed), if those requirements are already met,
ansible won't do anything. 

You can check the `apt` log to see exactly what Ansible did:

    cat /var/log/apt/history.log

Ansible used the built-in `apt` binary to install packages.

Let's `upgrade` a package with Ansible, see which one needs updating and update
it (in this case, it's `locales`):

    ansible all -m apt -a "name=locales state=latest" --become \
    --ask-become-pass;

The package was updated. `state=latest` ensures that the package is the latest
version available.

Let's use a different argument altogether:

    ansible all -m apt -a "upgrade=dist" --become --ask-become-pass;

This upgrades the entire system. To confirm, log into the servers and run:

    sudo apt dist-upgrade

You just updated all the servers with 1 command.
