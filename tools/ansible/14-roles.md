# Roles

[**Contents**](01-intro.md)

You can refactor your playbook by setting up roles. They allow you to split up
your tasks so that it makes a lot more sense.

First off, back up your main playbook:

    cp site.yml site.yml.bak

In the `site.yml` you will do everything, including the tasks from the
bootstrap file. Even though the file works as it is, you want to clean it up.

Edit the `site.yml` file:

    vim site.yml

Add the following text to it:

```yaml
---

- hosts: all
  become: true
  pre_tasks:

  - name: update repository index (CentOS)
    tags: always
    dnf:
      update_cache: yes
    changed_when: false
    when: ansible_distribution == "CentOS"
    
  - name: update repository index (Ubuntu)
    tags: always
    dnf:
      update_cache: yes
    changed_when: false
    when: ansible_distribution == "Ubuntu"

  # from here on things are different

- hosts: all
  become: true
  roles:
    - base

- hosts: workstations
  become: true
  roles:
    - workstations

- hosts: web_servers
  become: true
  roles:
    - web_servers

- hosts: db_servers
  become: true
  roles:
    - db_servers

- hosts: file_servers
  become: true
  roles:
    - file_servers
```

Create a new `roles` directory structure for your roles:

```
mkdir -p roles/{base,db_servers,web_servers,workstations,file_servers}/tasks 
```

Create `main.yml` files in each tasks directory:

```
cd roles;
touch {base,db_servers,web_servers,workstations,file_servers}/tasks/main.yml;
```

Add tasks to the files.

`base/tasks/main.yml`:

```yaml
- name: add ssh key for simone
  authorized_key:
    user: simone
    key: "ssh-ed25519 <key> ansible" 
```

`db_servers/tasks/main.yml`:

```yaml
- name: install mariadb server package (CentOS)
  tags: centos,db,mariadb
  dnf:
    name: mariadb
    state: latest
  when: ansible_distribution == "CentOS"

- name: install mariadb server package (Ubuntu)
  tags: db,mariadb,ubuntu
  dnf:
    name: mariadb
    state: latest
  when: ansible_distribution == "Ubuntu"
```

`file_servers/tasks/main.yml`:

```yaml
- name: install samba package
  tags: samba
  package:
    name: samba
    state: latest
```

`web_servers/tasks/main.yml`:

```yaml
- name: install httpd package (CentOS)
  tags: apache,centos,httpd
  dnf:
    name:
      - httpd
      - php
    state: latest
  when: ansible_distribution == "CentOS"
 
- name: start and enable httpd (CentOS)
  tags: apache,centos,httpd
  service:
    name: httpd
    state: started
    enabled: yes
  when: ansible_distribution == "CentOS"

- name: install apache2 package (Ubuntu)
  tags: apache,apache2,ubuntu
  apt:
    name:
      - apache2
      - libapache2-mod-php
    state: latest
  when: ansible_distribution == "Ubuntu"

- name: change e-mail address for admin
  tags: apache,centos,httpd
  lineinfile:
    path: /etc/httpd/conf/httpd.conf
    regexp: '^ServerAdmin'
    line: ServerAdmin somebody@somewhere.net
  when: ansible_distribution == "CentOS"
  register: httpd

- name: restart httpd (CentOS)
  tags: apache,centos,httpd
  service:
    name: httpd
    state: restarted
  when: httpd.changed    

- name: copy html file for site
  tags: apache,apache,apache2,httpd
  copy:
    src: default_site.html
    dest: /var/www/html/index.html
    owner: root
    group: root
    mode: 0644
```

`workstations/tasks/main.yml`:

```yaml
- name: install unzip
   package:
     name: unzip
 
 - name: install terraform
   unarchive:
     src: https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip
     dest: /usr/local/bin
     remote_src: yes
     mode: 0755
     owner: root
     group: root
```

These are not really playbooks, these are taskbooks. Now you have most of the
roles set up.

In the `roles/web_servers`, you need to create a `files` directory:

    mkdir roles/web_servers/files

Copy the default site file there:

    cd roles/web_servers/files;
    cp ../../files/default_site.yml .

You need it since you have a task that copies HTML file for a site.

Now you have everything set up. Try running the new playbook:

    ansible-playbook site.yml

It should've worked. How did it all work?

The `site.yml` playbook ran first, updated the cache, then it ran the `hosts:
all` plays, applied the `base` role to every server. It looked for a `roles`
folder, then it looked for the `base` folder, it then looked for a `tasks`
folder (it's required), and then ran every task from the `main.yml` file. It
goes through the same processes for the rest of the roles.

There are also a slight difference in the output, it adds the role of a task,
for example: 

```
TASK [base : add ssh key for simone]
```
