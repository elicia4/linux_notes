# The `pass` Password Manager

[***Table of Contents***](/README.md)

You password should:
- be long
- contain uppercase, lowercase, numbers, and unique characters
- be unique (1 password per service)

Use a password manager! The standard Unix password manager is `pass`. It's
local, nice and secure. Big online password managers are huge targets and will
most likely get hacked one day.

It can do onetime passwords as well.

Install it!

```bash
pacman -S pass
pacman -S pass-otp
```

`pass` is really just a shell script, it's not a compiled binary, it's a very
simple program. It uses gpg, in order to use it you need a gpg key pair. To
generate it:

```bash
gpg --full-gen-key;
# you can use RSA, make it 4096 long, set expiration to your preference
# enter a name and an email, they're mandatory (the comment isn't)
# it will prompt you for a password for your new keypair, come up with
# something difficult and save it. move your mouse for a bit after and you're
# done.
```

`pass` will encrypt all of your passwords with your `gpg` key. Never give
anyone your `gpg` key pair. You can give out your private key to anyone. They
can encrypt their mail with it and only YOU will be able to decipher it.

Finally, you can create a password store:

```bash
pass init <email>
```

This email has nothing to do with your passwords, your actual e-mail doesn't
matter, it's just there for the program to do its magic.

To add a password:

```bash
# pass add <name>
pass add email # just enter it twice, it's not saved
```

Specifically, `pass` uses `gpg` and encrypts a file in your home directory.

To see your password now:

```bash
pass email # you will be prompted for the passphrase
```

And now you can see your password. 

These password are now be accessed incredibly easily with your scripts/commands
and are very secure.

To get access to your passwords, one would need access to your:
- home directory
- gpg key pair
- key pair passphrase

To see a list of all the passwords you have:

```bash
pass ls
```

You can call up passwords with `passmenu` (pairs incredibly well with `dmenu`),
try this out!

```bash
passmenu # enter a name, after you press 'enter' the password will be in your
# clipboard
```

You can bind this to a keyboard shortcut.

You can type out the password with `passmenu` instead:

```bash
passmenu --type # very useful in a browser
# note that you need `xdotool` for it
```

When you log in, you will need to give your `gpg` password, you can solve this
by using [pam-gnupg](https://github.com/cruegge/pam-gnupg). This little program
is a PAM module that hands over your login password to `gpg-agent` (passes your
login password to "`gpg`", if your login password and your gpg key pair use the
same password, you won't need to enter it).

Let's imagine you have to do one time passwords. They usually advise you to do
some QR code scanning with your phone and your OTP application for that. You
don't need all of this stuff, you can use your computer for all of it. :)

To look at the content of a QR code:

```bash
zbarimg -q qr.png
```

To integrate the result into `pass`:

```bash
# pass otp add <name>
pass otp add otp-service-name
```

Enter the full `otpauth://` URI thing.

To get the one time password:

```bash
pass otp registarotp
# pass registarotp will output the `otpauth` thing
```
