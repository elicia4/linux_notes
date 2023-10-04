# Learn Ansible

![Ansible Logo](img/ansible.png)

Notes taken on the "Getting started with Ansible" playlist by LearnLinuxTV.

[***go back to README***](/README.md)

1. Introduction(you are here).
1. [SSH Overview & Setup](02-ssh.md)
1. [Setting up the Git Repository](03-git.md)
1. [Running ad-hoc Commands](04-ad-hoc.md)
1. [Running elevated ad-hoc Commands]()
1. [Writing our first Playbook]()
1. [The 'when' Conditional]()
1. [Improving your Playbook]()
1. [Targeting Specific Nodes]()
1. [Tags]()
1. [Managing Files]()
1. [Managing Services]()
1. [Adding Users & Bootstrapping]()
1. [Roles]()
1. [Host Variables and Handlers]()
1. [Templates]()

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
