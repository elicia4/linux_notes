# Templates

[**Contents**](01-intro.md)

Templates have variables in them that can be applied to multiple hosts, you can
then independently change the variable on each host as you see fit. It's a
great to provision servers that have services and config files that you need to
manage.

We will configure `ssh`. You should have the following file:

    cat /etc/ssh/sshd_config

This file is at the same path for each distribution, but each distrubution will
have different defaults for this file. Create a new directory:

    mkdir roles/base/tasks/templates;
    cd roles/base/tasks/templates;

Grab the `sshd_config` file and copy it here:

    cp /etc/ssh/sshd_config sshd_config_ubuntu.j2

`.j2` is the default extension for templates in Ansible (jinja2). Grab the same
file from the CentOS system:

    scp <CentOS-host>:/etc/ssh/sshd_config sshd_config_centos.j2

If this doesn't work, change the permissions on the server first:

    ls -l /etc/ssh/sshd_config;
    sudo chmod a+r /etc/ssh/sshd_config;

After getting the file, change it back:

    sudo chmod o-r /etc/ssh/sshd_config 

If your server is important to you, take a close look at the detailed ls output
to see the permissions.

Add the `AllowUsers` string to the CentOS config file, use variables, you can
add the line anywhere in the SSH config:

    AllowUsers  {{ ssh_users }}

Add the following lines to the `host_vars` files, for the Ubuntu hosts:

```yaml
ssh_users: "jay simone"
ssh_template_file: sshd_config_ubuntu.j2
```

For the CentOS hosts:

```yaml
ssh_users: "jay simone"
ssh_template_file: sshd_config_centos.j2
```

Go to `roles/base/tasks` to add a task:

    vim main.yml

Add it:

```yaml
- name: generate sshd_config file from template
  tags: ssh
  template:
    src: "{{ ssh_template_file }}"
    dest: /etc/ssh/sshd_config
    owner: root
    group: root
    mode: 0644
  notify: restart_sshd # handler 
```

Create a handler:

    cd ..;
    mkdir handlers;
    vim handlers/main.yml;

Create a play there:

```yaml
- name: restart_sshd
  service:
    name: sshd
    state: restarted
```

Now everything should work. Go to the root of the Ansible directory and run the
playbook:

    ansible-playbook site.yml

Templates give you a starting point and you can add variables to differentiate
them from one host to another.

That's it :)
