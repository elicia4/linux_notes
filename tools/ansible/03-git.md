# Setting up the Git Repository

[**Contents**](01-intro.md)

You have to have a git repository for all your Ansible code. When you use
Ansible in the real world, you're going to be using version control for your
scripts, Ansible configurations and so on.

To make sure git's installed:

    which git

To install it:

    sudo apt update; sudo apt install git

Create a new Github repository, clone it to your local machine. 

Provide it with your name and email:

    git config --global user.name "Your Name"
    git config --global user.email your_email@somewhere.in.the.world

To see that information:

    cat ~/.gitconfig

To add a change to a file:

    git add <filename>

To see what's changed:

    git diff <filename>

To commit the changes:

    git commit -m "your commit message"

To push your changes to the remote repository:

    git push origin main

You can create a private repository to hide your files.
