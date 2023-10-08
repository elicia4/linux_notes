# Targeting Specific Nodes

[**Contents**](01-intro.md)

You can run different things on different categories of servers.

Divide your playbook back into two tasks again:

```yaml
---
- hosts: all
  become: true
  tasks:

  - name: install apache and php for Ubuntu servers
    apt: 
      name:
        - apache2
        - libapache2-mod-php
      state: latest
      update_cache: yes
    when: ansible_distribution == "Ubuntu"

  - name: install apache and php for CentOS servers
    dnf:
      name:
        - httpd
        - php 
      state: latest
      update_cache: yes
    when: ansible_distribution == "CentOS"
```

Remove the variables from the `inventory` files as well:

```
<host>
<host>
```

Let's create a few groups there:

```
[web_servers]
<host>
<host>

[db_servers]
<host>

[file_servers]
<host>
```

Let's create a new playbook file:

    cp install_apache.yml site.yml

This is a playbook to provision the entire site. Let's make some changes:

```yaml
---
- hosts: all # this section is targeted at all hosts
  become: true
  tasks:

    # new plays
  - name: install updates (CentOS)
    dnf:
      update_only: yes
      update_cache: yes
    when: ansible_distribution == "CentOS"

  - name: install updates (Ubuntu)
    dnf:
      update: dist
      update_cache: yes
    when: ansible_distribution == "Ubuntu"

# Only do this for web servers. No need to update cache anymore.

- hosts: web_servers
  become: true
  tasks:

  - name: install apache and php for Ubuntu servers
    apt: 
      name:
        - apache2
        - libapache2-mod-php
      state: latest
    when: ansible_distribution == "Ubuntu"

  - name: install apache and php for CentOS servers
    dnf:
      name:
        - httpd
        - php 
      state: latest
    when: ansible_distribution == "CentOS"
``` 

Test this new playbook out:

    ansible-playbook --ask-become-pass site.yml

Take a close look at changes in the output. There's a `PLAY [all]` section and
a `PLAY [web_servers]` section. In the first one, it targets all four hosts, in
the second only the two `web_servers` ones, just like it was intended.

Change `tasks` to `pre_tasks` at the beginning. This makes sure that these
tasks run before anything else in the playbook. Let's add another section at
the end:

```yaml
- hosts: db_servers
  become: true
  tasks:

  - name: install mariadb package (CentOS)
    dnf:
      name: mariadb
      state: latest
    when: ansible_distribution == "CentOS"

  - name: install mariadb package (Ubuntu)
    apt:
      name: mariadb-server
      state: latest
    when: ansible_distribution == "Ubuntu"
```

This should work. We need a section for `file_servers`:

```yaml
- hosts: file_servers
  become: true
  tasks: 

  - name: install samba package
    package: 
      name: samba
      state: latest
```

We split all our hosts into four groups, so that we can run different tasks on 
different machines.

Play around with this stuff, create a play for a group, for example:

```yaml
- hosts: web_servers
  become: true
  tasks:

  - name: install nginx on Ubuntu web servers
    apt:
      name: nginx
      state: latest
    when: ansible_distribution == "Ubuntu"
```
