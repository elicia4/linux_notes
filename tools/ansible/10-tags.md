# Tags

[**Contents**](01-intro.md)

You can target specific groups of hosts with Ansible, so that way you can have
different categories of servers and make Ansible react accordingly. What's not
so good is that you have to run your playbooks against every single server
every single time.

We'll learn how to use tags to add some metadata to your plays so that you can
only run the plays you want to test. It will make testing your playbooks even
easier.

Open up your most recent playbook:

    vim site.yml

Let's add a tag to `pre_tasks`:

```yaml
...
pre_tasks:

- name: install updates (CentOS)
  tags: always
...
- name: install updates (Ubuntu)
  tags: always
```

Let's also add some tasks to `web_servers`:

```yaml
...
- name: install apache and php for Ubuntu servers
  tags: apache,apache2,ubuntu
...
- name: install apache and php for CentOS servers
  tags: apache,centos,httpd
```

...and to `db_servers`:

```yaml
...
- name: install mariadb package (CentOS)
  tags: centos,db,mariadb
...
- name: install mariadb package (Ubuntu)
  tags: db,mariadb,ubuntu
...
```

...and to our only file servers:

```yaml
...
- name: install samba package
  tags: samba
...
```

The `always` tags will make it so that play *always* runs. 

After that, all kinds of tags were added, you add whatever ones you want. You
come up with your own system for tags, it really doesn't matter.
`apache,apache2,ubuntu` were used because:

- `apache` relates to the type of software
- `apache2` is the name of the package
- `ubuntu` is the destribution

Run the playbook by itself to make sure there are no syntax errors:

    ansible-playbook --ask-become-pass site.yml

To view your tags:

    ansible-playbook --list-tags site.yml

If you want to target the tag `centos`:

    ansible-playbook --tags centos --ask-become-pass site.yml

You can target multiple tags as well:

    ansible-playbook --tags "apache,db" --ask-become-pass site.yml
