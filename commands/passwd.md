# The `passwd` command

Notes taken on the "Linux Crash Course - The `passwd` Command" video by
LearnLinuxTV.

[***go back to README***](/README.md)

The command allows you to change passwords.

Running the `passwd` with no options will change the password of the currently
logged in user:

    passwd

To view statistics regarding your password:

    sudo passwd -S username

Anything outside of changing your own password is limited to root, hence the
need for `sudo`. The fields are:

- Username
- Password status: either `L`/`LK` for "locked", `NP` for "no password" or
  `P`/`PS` for usable password
- Date of the last password change
- Minimum age (in days), how old the password has to be before the next
  password change is available
- Maximum age (in days), maximum number of days before the password has to be
  changed
- Warning period (in days), number of days prior to password expiration in
  which the user will see password expiration warnings
- Inactivity period (in days), number of days after password expiration that
  the account will become locked out. `-1` means never

Create an account to experiment with it:

    sudo useradd voltron

To switch to the user:

    su - voltron

But it's asking for a password that was never set. Set it!

    sudo passwd voltron

You can switch now:

    su - voltron

To lock voltron's password:

    sudo passwd -l voltron

View voltron's stats:

    sudo passwd -S voltron

It now has `L`/`LK` in the second field, the account is locked :( You can't
switch to that user now.

To unlock:

    sudo passwd -u voltron

To add an expiration date to a password:

    # sudo passwd -x <number-of-days-from-now> <username>
    sudo passwd -x 30 voltron

What if you want the password to expire right now?

    # -e for expire
    sudo passwd -e voltron

It now has `1969` in its second field.

To delete a user's password:

    # sudo passwd -d <username>
    sudo passwd -d voltron

It now has `NP`, it means "no password":

    sudo passwd -S voltron

The advantage of deleting a user's password instead of locking them out is that
you can log right in without entering a password. It can be a security concern.
