# The `when` conditional

[**Contents**](01-intro.md)

With 'when' you differentiate a playbook by host, determine which distribution
a host is running. It's common on most Linux shops to run multiple
distributions.

To pull changes from a remote repository:

    git pull

To run a playbook:

    ansible-playbook --ask-become-pass install_apache.yml

If you add a non-Debian host to your hosts, you won't be able to run the `dnf`
commands on it.

To see your what your distribution is:
    
    cat /etc/os-release

We should't run the `dnf` module against distributions that do not support it:

    ---

    - hosts: all 
      become: true 
      tasks: 

      - name: update repository index
        dnf:
          update_cache: yes 
        when: ansible_distribution == "Ubuntu" # only run this if your
        # distribution is Ubuntu

If you run this playbook on a non-Ubuntu machine, it will just skip it, it will
be stated in the output.

If you want to run this against multiple distributions:

    when: ansible_distribution in ["Ubuntu", "Debian"] # in instead of ==

To gather facts about your hosts:

    ansible all -m gather_facts --limit <new_server>

If you wanted to run something against VirtualBox virtual machines, you could
target your `when` statement against the `ansible_product_name` variable. To
see what OS a machine is running:

    ansible all -m gather_facts --limit <new_server> | grep \
    ansible_distribution

You can use `when` with any of these variables. You can also use multiple
conditions:

    when: ansible_distribution == "CentOS" and ansible_distribution_version = "8.2"

Let's add the same plays for `CentOS`:

    ---

    - hosts: all 
      become: true 
      tasks: 

      - name: update repository index
        dnf: # dnf instead of apt
          update_cache: yes # this works on CentOS as well
        when: ansible_distribution == "CentOS"

      - name: install apache2 package 
        dnf: 
          name: httpd # package names are also different
          state: latest
        when: ansible_distribution == "CentOS"

      - name: add php support for apache
        dnf:
          name: php
          state: latest
        when: ansible_distribution == "CentOS"

If you run this, these plays should run on CentOS. There's another problem,
CentOS doesn't start the `httpd` service by default. You can start it up
manually:

    sudo systemctl start httpd

You should refrain from running manual commands, you want to automate
everything. You should also allow communication to port 80:

    sudo firewall-cmd -add-port=80/tcp 

It should now work. You want to automate both of these commands later. Add
everything to version control.
