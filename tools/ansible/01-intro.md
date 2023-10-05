# Learn Ansible

![Ansible Logo](img/ansible.png)

Notes taken on the "Getting started with Ansible" playlist by LearnLinuxTV.

[***go back to README***](/README.md)

1. Introduction(you are here).
1. [SSH Overview & Setup](02-ssh.md)
1. [Setting up the Git Repository](03-git.md)
1. [Running ad-hoc Commands](04-ad-hoc.md)
1. [Running elevated ad-hoc Commands](05-el_ad-hoc.md)
1. [Writing our first Playbook](./06-playbook.md)
1. [The 'when' Conditional](./07-when.md)
1. [Improving your Playbook](./08-improve_pb.md)
1. [Targeting Specific Nodes](./09-target_nodes.md)
1. [Tags](./10-tags.md)
1. [Managing Files](./11-files.md)
1. [Managing Services](./12-services.md)
1. [Adding Users & Bootstrapping](./13-users_bootstrap.md)
1. [Roles](./14-roles.md)
1. [Host Variables and Handlers](./15-vars_handlers.md)
1. [Templates](./16-templates.md)

- [Guide Files](./materials/)

### Introduction

The purpose of Ansible is to provision servers, you don't want to do manual
work to spin them up, you want to automate as much as you possibly can. Where
does Ansible fit? Most of the time you have an "Ansible Control Host", which is
an Ansible server.

The server connects to servers to issue commands to provision them. The servers
don't have to have Ansible installed, you should only have Ansible on the
control host. It connects via SSH to the servers and provisions them. 

You server/laptop/workstation contains the scripts(playbooks) that are used to
run Ansible against the servers. In the real world, you could have a git
repository with all of you Ansible playbooks. 

**(!!!)** You should create a couple of VM's to simulate the process of
configuring servers.
