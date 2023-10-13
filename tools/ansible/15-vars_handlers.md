# Host Variables and Handlers

[**Contents**](01-intro.md)

You need to create a new directory that will store the files that contain the
variables:

    mkdir host_vars

Create files for each host in the `host_vars` directory with the following
format: `<host>.yml`

Match them with the addresses in the inventory file. You can create the host
variables inside these files, in the Ubuntu host file:

```yaml
apache_package_name: apache2
apache_service: apache2
php_package_name: libapache2-mod-php
```

In the CentOS file:

```yaml
apache_package_name: httpd
apache_service: httpd
php_package_name: php
```

You can refer to these variables in the taskbooks, it allows you to generalize
your playbooks. Go to the `web_servers` taskbook:

    vim roles/web_servers/tasks/main.yml

You can make it better:

```yaml
- name: install apache and php packages
  tags: apache,web_server,php
  package:
    name:
      - "{{ apache_package_name }}"
      - "{{ php_package_name }}"
    state: latest

- name: start and enable apache service
  tags: apache,httpd
  service:
    name: "{{ apache_service }}"
    state: started
    enabled: yes

- name: change e-mail address for admin # keep it the same way, it only works
                                        # for CentOS.
  # ...

- name: restart httpd
  tags: apache,httpd
  service:
    name: "{{ apache_service }}"
    state: restarted
  when: apache.changed

  # ...

```

You use variables instead of calling values out specifically. Run the playbook:

    ansible-playbook site.yml

Let's take a look at the concept of a handler:

    vim roles/web_servers/tasks/main.yml

Take a look at the following part of the taskbook:

```yaml
...
- name: change e-mail address for admin
  tags: apache,centos,httpd
  lineinfile:
    path: /etc/httpd/conf/httpd.conf
    regexp: '^ServerAdmin'
    line: ServerAdmin somebody@somewhere.net
  when: ansible_distrubution == "CentOS"
  register: apache

- name: restart httpd
  tags: apache,httpd
  service:
    name: "{{ apache_service }}"
    state: restarted
  when: apache.changed
...
```

As we know from the previous note, working with `register`s can get messy.
There is a better way to handle this, remove the `restart httpd` play, we will
use a handler instead:

```yaml
...
- name: change e-mail address for admin
  tags: apache,centos,httpd
  lineinfile:
    path: /etc/httpd/conf/httpd.conf
    regexp: '^ServerAdmin'
    line: ServerAdmin somebody@somewhere.net
  when: ansible_distrubution == "CentOS"
  notify: restart_apache # we changed this line, restart_apache is a play
...
```

Go to the `roles/web_servers` folder. Create a new directory:

    mkdir handlers

Create a new file there:

    vim main.yml

Add this to it:

```yaml
- name: restart_apache # the name is equal to the name of the notify
  service:
    name: "{{ apache_service }}"
    state: restarted
```

This is not going to work since it the e-mail change won't trigger (since it's
already there). Change the e-mail to `somebody@somewhere.com` so that it's
different. Run the playbook:

    ansible-playbook site.yml

The handler should run and restart `apache`. You should've gotten a `RUNNING
HANDLER ...` line in the output. This works a lot better than running the
register.

The `change e-mail` task got executed, notified the `restart_apache` task,
Ansible looked for the `handlers` folder in the `roles/web_servers` directory,
found the `main.yml` file and executed the `restart_apache` task.
    
