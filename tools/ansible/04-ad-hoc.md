# Running ad-hoc Commands

[**Contents**](01-intro.md)

Install Ansible:

    sudo apt update; sudo apt install ansible

To run it effectively you need an inventory file. It will contain IP addresses
for each of the hosts you want to manage with Ansible:

    vim inventory

Add the IP addresses there. Add the file to version control. If your repository
is public, **DO NOT USE** real IP addresses. Commit your changes, push them.

You can specify a user and a port there too:

    <IP> ansible_port=<port> ansible_user=<name>

Let's run an Ansible command to make sure that everything is working:

    ansible all --key-file ~/.ssh/ansible_key -i inventory -m ping

This is going to make a connection to each one of the hosts inside the
`inventory` file.

You just run `ansible` against `all`, you specified the `--key-file`, you gave
it an inventory file with `-i`, and you ran a `ping` module. You should've
gotten `SUCCESS` messages after running the command. If not, make sure that
your ports and usernames are right.

As an admin, you want to automate EVERYTHING. Let's create an ansible config
file:

    vim ansible.cfg

This file is read by `ansible` whenever you run it. Set some defaults there:

    [defaults]
    inventory = inventory
    private_key_file = ~/.ssh/ansible_key

You can now shorten your command to this:

    ansible all -m ping

The reason that works is because you declared the defaults in the `ansible.cfg`
file.

To show a list of hosts:

    ansible all --list-hosts

Another useful command:

    ansible all -m gather_facts

When ansible connects to a server, it's pulling a list of information about
that server including the processor that it has, the OS it's running, all of
the environment variables and so on. You can limit that to only one of the
hosts:

    ansible all -m gather_facts --limit <IP>

You can grab any information specific to the host from the output. You can use
it for troubleshooting.

Make sure you're synchronized with GitHub.
