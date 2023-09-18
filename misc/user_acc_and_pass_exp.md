# User Account & Password Expiration

Notes on the video "Linux Crash Course - User Account & Password Expiration" by
LearnLinuxTV.

[***go back to README***](/README.md)  

You can make a user account expire and/or their password expire. We're going to
focus on the `chage` command. 

We can set a user account to be locked out after a certain time or make them
change their password after a certain time.

Create 3 users to play around with:

    sudo useradd -d /home/neo -m neo
    sudo useradd -d /home/trinity -m trinity 
    sudo useradd -d /home/morpheus -m morpheus

The `-d` option specifies the user's login directory, the `-m` option is needed
to create the directory itself.

Check out if you created them successfully:

    cat /etc/passwd

To set the expiration date for a user's account:

    sudo chage -E 2025-01-09 neo # 9th of January, 2025

The user won't be able to log in after the date. To check an account's aging
information:

    sudo chage -l neo

Set whatever dates you want for `trinity` and `morpheus` accounts, as an
exercise :)

To set the number of day until a password expires:

    sudo chage -M 30 trinity

The `Password expires` field should now be 30 days ahead of `Last password
change`. To undo that (to remove the password expiration date):

    sudo chage -M -1 trinity

To set a minimum number of days between password changes (so that users can't
cheat the password policies (some user are incredibly sneaky, just set it)):

    sudo chage -m 7 morpheus

If a user needs to change their password because of a security issue, they can
always contact the sysadmin to do that.

To lock a user account immediately (if a user account got compromised):

    sudo passwd -l trinity

To unlock an account:

    sudo passwd -u trinity
