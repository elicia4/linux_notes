#  Managing Files

[**Contents**](01-intro.md)

We will learn how to copy files to a server with Ansible. This is useful for
configuration files, databases etc. 

Make sure to `git pull` every time you in a team.

Create a new directory: 

    mkdir files

By default, git doesn't copy empty directories (`git status`). Create an file
in that directory:

    vim files/default_site.html

Fill it in with something simple for the sake of example:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Website Test</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/style.css" rel="stylesheet">
  </head>
  <body>
    <h1>Website Test</h1>
    <p>Ansible is awesome!</p>
  </body>
</html>
```

In our playbook, we need a play that copies this file to the server:

    vim site.yml

Go to the end of the `web_server` section and create a new play:

```yaml
...
- name: copy default html file for site
  tags: apache,apache2,httpd
  copy: # the new module for copying files, it allows us to copy files to the
        # server
    src: default_site.html # local path to the file, the "files" dir is assumed
    dest: /var/www/html/index.html # path to the file on the server, doesn't
                                   # need to be the same
    owner: root # file owner
    group: root # group owner
    mode: 0644 # permissions
```

It's useful to note that you can name the file on the server whatever you want,
you make them hidden too (i.e. `.index.html`).

Run everything so that you can see the difference:

    ansible-playbook --ask-become-pass site.yml

Check if the files exists in the remote repo:

    ssh <host> cat /var/www/html/index.html 

Check it in your browser as well. Make sure to sync everything with GitHub.

Let's add some more to the playbook:

    vim site.yml

Add this text after update installation:

```yaml
- hosts: workstations # this section is targeted toward workstations
  become: true # root privileges 
  tasks:

  - name: install unzip # installs the unzip package
    package:
      name: unzip

  - name: install terraform # install terraform
    unarchive: # allows us to unzip a zip file
      src: https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip
      dest: /usr/local/bin # we are making the terraform dir available from
                           # that directory
      remote_src: yes # telling Ansible to not bother looking for the file
                      # locally, it's remote
      mode: 0755
      owner: root
      group: root
```

The terraform zip file only includes one file. This won't work because there
are no `workstations` in the inventory list:

    vim inventory

Add `workstations`:

```
[workstations]
<host>
```

Add the Ansible key to the workstation:

    ssh-copy-id -i <file> <host>

The key takeaway is that you can not only provision your servers, you can use
Ansible to configure your local workstations as well. 

Run the playbook:

    ansible-playbook --ask-become-pass site.yml

To see if `terraform` was installed:

    which terraform

You learned how to copy files to and unpack archives on your servers.
