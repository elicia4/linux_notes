# Writing our first Playbook 

[**Contents**](01-intro.md)

The real strength of Ansible comes from its playbooks. When we write a playbook
we can define a state we want our servers to be in and the plays/commands that
Ansible will carry out to bring our servers to that state.

Let's create a playbook, it should have a `.yml` extension:

    vim install_apache.yml

`.yml` is standard extension for playbook files. Add the following text to the
file:
    
```yaml
---

- hosts: all # run it on all hosts
  become: true # sudo privileges
  tasks: # list of plays to do 

  - name: install apache2 package # the title that will be shown in the output
    apt: # the module you want to use
      name: apache2 # name of the package you want to install
```

Everything should be aligned correctly, exactly the same way as it's aligned
here. To run a playbook:

    ansible-playbook --ask-become-pass install_apache.yml

Ansible gathers facts every time. Before it runs any playbooks, it gathers all
the information in needs about the hosts it interacts with (OS, Distro, release
version and so on), Then it executes the play you configured, it says that it
ran it against every server and changed something. At the end, it gives a recap
of what it did on every host. 

Ansible only changes the things that are necessary to change, that's what
`changed=1` means. It there was some connection issue, it would say
`unreachable=1`. `skipped` is when you have a task that runs only if some
condition is true. `rescued` means that if a task failed, a rescue play ran.
`ignored`: you can ignore things.

Run the command a second time, notice that `changed` is now `0`. That's because
the package is already installed.

If you change the package name to one that doesn't exist, you get `failed=1`:

```yaml
---

- hosts: all # run it on all hosts
  become: true # sudo privileges
  tasks: # list of plays to do 

  - name: install chocobo package # the title that will be shown in the output
    apt: # the module you want to use
      name: chocobo # name of the package you want to install
```

Run it:

    ansible-playbook --ask-become-pass install_apache.yml

Let's update the repository index in the playbook:

```yaml
---

- hosts: all 
  become: true 
  tasks: 

  - name: update repository index
    apt:
      update_cache: yes # this updates the repo index

  - name: install apache2 package 
    apt: 
      name: apache2
```

Run it:

    ansible-playbook --ask-become-pass install_apache.yml

Let's install another package:

```yaml
---

- hosts: all 
  become: true 
  tasks: 

  - name: update repository index
    apt:
      update_cache: yes 

  - name: install apache2 package 
    apt: 
      name: apache2

  - name: add php support for apache
    apt:
      name: libapache2-mod-php
```

Run it:

    ansible-playbook --ask-become-pass install_apache.yml

Now you can install 2 packages with one playbook. Let's make them update to the
latest version as well:

```yaml
---

- hosts: all 
  become: true 
  tasks: 

  - name: update repository index
    apt:
      update_cache: yes 

  - name: install apache2 package 
    apt: 
      name: apache2
      state: latest

  - name: add php support for apache
    apt:
      name: libapache2-mod-php
      state: latest
```

Let's create a playbook that removes the packages:

    cp install_apache.yml remove_apache.yml

To remove the packages, you change the `state` to `absent`:

```yaml
---

- hosts: all 
  become: true 
  tasks: 

  - name: remove apache2 package 
    apt: 
      name: apache2
      state: absent

  - name: remove php support for apache
    apt:
      name: libapache2-mod-php
      state: absent
```

Run it:

    ansible-playbook --ask-become-pass remove_apache.yml

As you can see, it worked. You can install the packages back:

    ansible-playbook --ask-become-pass install_apache.yml

These playbooks are incredibly inefficient, we'll see how we can improve them
later.

Add the playbooks to git.
