# Improving your Playbook

[**Contents**](01-intro.md)

You want to make sure that your playbook is as efficient and as easy to
understand as possible.

You have 3 tasks for each distribution. You shouldn't have two plays for
installing packages, you can consolidate them into one.

```yaml
- name: install apache2 & php support 
  apt: 
    name: # add a list of packages
      - apache2 
      - libapache2-mod-php
    state: latest
  when: ansible_distribution == "Ubuntu"
```

Do the same thing with CentOS plays. Your playbooks is more efficient and
easier to read now.

You can shorten this even further, you can add the repository index update to
the package installation play:

```yaml
- name: install apache2 & php support
  apt: 
    name: 
      - apache2 
      - libapache2-mod-php
    state: latest
    update_cache: yes # add it here 
  when: ansible_distribution == "Ubuntu"
```

Yet again, you can do the same thing to the CentOS plays. The developers of
Ansible try to keep similiar options for different modules named the same way,
in this case the `update_cache` option is the same.

You can shorten these remaining two plays to one:

```yaml
---

- hosts: all 
  become: true 
  tasks: 

  - name: install apache & php 
    package: # generic package manager module, it uses the PM of the host
      name: 
        - "{{ apache_package }}" # this is a variable ("{{ var }}")
        - "{{ php_package }}"
      state: latest
      update_cache: yes 
```

Edit the `inventory` file as well. You should declare the variables you just
added to your playbook.

```
<host> apache_package=apache2 php_package=libapache2-mod-php
<host> apache_package=apache2 php_package=libapache2-mod-php
<host> apache_package=apache2 php_package=libapache2-mod-php
<host> apache_package=httpd php_package=php
```

There's a better way of doing this, but this will do for now. You just declared
different variables for different hosts, the first three lines are for Ubuntu
hosts, the last one is a CentOS one. 

You just condensed all those plays into one.
