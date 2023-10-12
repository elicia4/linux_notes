# Managing Services

[**Contents**](01-intro.md)

You can manage services with Ansible.

When you install a package on CentOS that includes a service, it won't be
started automatically, it's left up to you. Let's make sure Apache is running
after Ansible installs it:

Open up the playbook:

    vim site.yml

Add a new play:

```yaml
- name: start httpd (CentOS)
  tags: apache,centos,httpd
  service: # the module for service management
    name: httpd
    state: started # starts the service, in this case "httpd"
  when: ansible_distribution == "CentOS"
```

Check the status of `httpd` service on the CentOS server:

    ssh <host> systemctl status httpd

If it's running, `stop` it. Run the playbook:

    ansible-playbook --ask-become-password site.yml

Check the status again, it should've started. To enable it as well:

```yaml
- name: start httpd (CentOS)
  tags: apache,centos,httpd
  service: 
    name: httpd
    state: started 
    enabled: yes # this line was added, it enables the service
  when: ansible_distribution == "CentOS"
```

Say for example you want to change a config file for a service, you likely have
to restart it after doing that. Edit the file:

    vim site.yml
    
Add this before `copy default html file for site`:

```yaml
- name: change e-mail address for admin
  tags: apache,centos,httpd
  lineinfile: # allows you to change a line in a file
    path: /etc/httpd/conf/httpd.conf # this changes the admin's e-mail address
                                     # in the apache config
    regexp: '^ServerAdmin' # line that begins with "ServerAdmin"
    line: ServerAdmin somebody@somewhere.net # The line you want to end up with
  when: ansible_distribution == "CentOS"
  register: httpd # allows Ansible to capture the state in a variable
``` 

Add another play:

```yaml
- name: restart httpd (CentOS)
  tags: apache,centos,httpd
  service:
    name: httpd
    state: restarted
  when: httpd.changed
```

After the `change e-mail address for admin` play gets executed, the variable
stores the state in the `httpd` variable. The next play executes whenever the
`httpd` get changed (`httpd.changed`).

Run the playbook:

    ansible-playbook --ask-become-password site.yml

Check out the `httpd.conf` file:

    cat /etc/httpd/conf/httpd.conf | grep ServerAdmin

Make sure to configure this carefully, you might get duplicated of the same
added line if you are not. 

Also, make sure that when you check for the `register` value, there are no
other register changes you are not aware of in the file. Let's say there's two
plays that change the register's value, the first of them makes some changes,
the second one doesn't. The value of the SECOND one will be in the register,
since it's the last one. 

In our example, if there was another play after the e-mail change, and it
didn't change anything, the server wouldn't restart, since the `httpd` register
didn't change last time.
