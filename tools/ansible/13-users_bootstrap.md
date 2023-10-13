# User Management

[**Contents**](01-intro.md)

You can automate user management with Ansible:

    vim site.yml

Add a new section after the `pre_tasks` section:

```yaml
- hosts: all
  become: true
  tasks:

  - name: create simone user
    tags: always
    user: # the module for adding users
      name: simone
      groups: root # this is just a test
```

Check the `/etc/passwd` file first:

    cat /etc/passwd | tail

Run the playbook and check the users again:

    ansible-playbook --ask-become-pass site.yml;
    cat /etc/passwd | tail

You just added `simone` to each of the hosts. We will now configure this user
to act as an Ansible user to run Ansible jobs in the background, we want
Ansible to be fully automated.

Let's add the Ansible ssh key for `simone`:

```yaml
  - name: add ssh key for simone
    tags: always
    authorized_key: # module for adding an ssh key
      user: simone
      key: "ssh-ed25519 <insert-key-here> ansible"
```

Let's add a sudoers file for `simone`:

```yaml
  - name: add sudoers file for simone # we want simone to use sudo without a
                                      # password
    tags: always
    copy:
      src: sudoer_simone
      dest: /etc/sudoers.d/simone
      owner: root
      group: root
      mode: 0440
```

Create the file itself inside the `files` directory:

    vim files/sudoer_simone

Add the following policy:

    simone ALL=(ALL) NOPASSWD: ALL

If you add a file to `sudoers.d` with the sudoers syntax, you are able to
control access to `sudo` by just adding or removing a file. If you add the
`simone` file here, it's going to add permissions for `simone`. 

Run the playbook, check if the file is there:

    ansible-playbook --ask-become-pass site.yml;
    ssh <IP> cat /etc/sudoers.d/simone

What this means is that you can use the `simone` user to carry out Ansible
tasks in the background should you ever need to do that.

Let's get rid of the `--ask-become-pass` option:

    vim ansible.cfg

Add a default `remote_user`:

    remote_user = simone

Try running the playbook withouth the option:

    ansible-playbook site.yml

It should've worked. 

When you set up a fresh server, you won't have a default user. It is therefore
suggested to create a bootstrap playbook to set up Ansible itself:

    cp site.yml bootstrap.yml

From the `site.yml` file, remove the `create simone user` task, the `add
sudoers file for simone` task. 

From the `bootstrap.yml` file, remove everything starting from the `- hosts:
workstations` file. The purpose of this file is to provision a new server
with basic configurations. This one install updates, creates the `simone` user,
adds an ssh key to it and a sudoers file.

Since the bootstrap script updates the server, you can delete the `update_only:
yes` and the `upgrade: dist` lines from `site.yml`.

Add the following lines to `site.yml`:

```yaml
...
dnf:
  update_cache: yes
changed_when: false

...
apt:
  update_cache: yes
changed_when: false
```

`changed_when` allows you to control what is considered a change, with `false`
the tasks are not considered changes.

Test the script:

    ansible-playbook --ask-become-pass bootstrap.yml

After that, test the main playbook:

    ansible-playbook site.yml

Change the verbiage in the `site.yml` from `install updates` to `update repo
cache`.

After doing all this, make sure to properly secure the Ansible key. If the key 
ever gets compromised, in the `add ssh key for simone` add `state: absent` to
remove the key.

Add everything to `git`.
