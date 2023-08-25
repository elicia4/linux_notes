# `usermod`

Notes taken on this video by LearnLinuxTV: https://youtu.be/p8QOnty6rSU

[***go back to README***](README.md)  

The command is used to modify users. E.g.

    # add a user to a group
    sudo usermod -aG group user
    # add user to sudo group
    usermod -aG sudo user

To see which groups a user is a member of:
    
    groups user

You can add a user to multiple groups at the same time:

    sudo usermod -aG admins,sudo user

You have to relog for the new groups' changes to take effect.

To change a user's home directory:

    sudo usermod -d /home/myhome --move-home user

The `--move-home` flag will move the contents of the old home directory to the
new one. You have to do it from another user's account / root.

After moving the home directory, log in and out and check your home directory:

    echo $HOME

The directory didn't have to exist before creating, it gets created
automatically.

To change the name of your user's account:

    usermod -l new old 

To check:

    cat /etc/passwd

To lock out a user:

    usermod -L user

To unlock a user:

    usermod -U user 

To set and expiration date for a user's password:

    usermod user -e 2023-08-26

To check user password expiry information:

    chage -l user
