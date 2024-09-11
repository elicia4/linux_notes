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

### `gpg` and `pass`

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

To list your secret keys:

```bash
gpg -K # secret
# gpg -k # public
```

To change the expiration date of your key:

```bash
gpg --edit-key <big_string_from_gpg_K>
# enter 'expire' to change the expiration date
# select new expiration date
# 'save' to save & quit
```

`pass` will encrypt all of your passwords with your `gpg` key. Never give
anyone your `gpg` key pair. You can give out your private key to anyone. They
can encrypt their mail with it and only YOU will be able to decipher it.

### Password Creation and Management

Finally, you can create a password store:

```bash
pass init <email>
```

This email has nothing to do with your passwords, your actual e-mail doesn't
matter, it's just there for the program to do its magic.

To initialize a git repository in your password directory:

```bash
pass git init
```

To add a password:

```bash
# pass add <name> # 'insert' is an alternative command
pass add email # just enter it twice, it's not saved
```

`pass` creates password files and encrypts them with `gpg`.

You can organize your passwords as you would files in a file system. To create
a directory and a password file inside it:

```bash
pass add email/first_email # pass created the directory and the file inside it
# you can nest multiple directories
# pass add cooking/some_cooking_site/first_account
```

To see your password now:

```bash
pass email # you will be prompted for the passphrase
```

To generate a password and insert it into the password store:

```bash
pass generate <name>
```

These password are now be accessed incredibly easily with your scripts/commands
and are very securely encrypted.

To get access to your passwords, one would need access to your:
- home directory
- gpg key pair
- key pair passphrase

To see a list of all the passwords you have:

```bash
pass ls
```

Or just use `pass`, it's the same thing as `pass ls`.

To find a password:

```bash
pass find <name>
```

Notice that `pass` has auto-completion, it works out of the box for me.

To remove a password file/directory:

```bash
pass rm <name>
pass rm -r <dir-name>
```

If you accidentally remove a password and want to revert that change, you can:

```bash
pass git log # to first view the history
# the commit you want to revert is likely the current HEAD
pass git revert HEAD
```

### Storing Your Passwords Remotely (E.g. on GitHub)

If you intend to store your passwords on a platform like GitHub, you should not
use your email address as your file name. If you were to do so, you would leak
credentials. 

To store your emails with your passwords, add them as additional lines in the
password files. To edit a password file:

```bash
pass edit <file>
```

A text editor should've opened up where you can change your file. Add the
metadata as new lines under the password:

```bash
<password-line>
email: <random>@<email>
```

The metadata is encrypted as well. To search files by metadata (it's magic
really):

```bash
pass grep "<random>@<email>"
```

Or you can just search by the metadata field itself:

```bash
pass grep "email:"
```

Note that when you will `pass show` with metadata, the entire file will be
shown. To only copy the first line and not display anything:

```bash
pass show -c <file>
```

After this lengthy introduction, you can push your password store to GitHub:

```bash
# add a remote named <name> for the repository at <URL>
# e.g.: pass git remote add <name> <URL> 
pass git remote add origin <git-repo>
# push the files to the remote
pass git push origin main
```

To now clone your password store to a new device:

```bash
git clone <git-repo> .password-store
pass show <entry> # <- THIS SHOULD FAIL
```

If it failed, everything's good! It means that the encryption is working, note
that when you uploaded the repository, you didn't push the gpg key pair with
it (AS YOU ABSOLUTELY SHOULDN'T DO).

On your main machine, export both the private and public parts of your key:

```bash
mkdir exported-keys
cd exported-keys
gpg --output public.pgp --armor --export <email> # --armor = base64
# you can use the email to specify the key
# --export = public, --export-secret-key = private
gpg --output private.pgp --armor --export-secret-key <email>
```

Now on your second machine you can retrieve the keys via `scp` (`ssh`):

```bash
scp -r username@hostname:exported-keys .
```

Now to add the keys:

```bash
gpg --import private.pgp
gpg --import public.pgp
```

Now `show` should work:

```bash
pass show <file>
```

Note that in order to encrypt new passwords on this machine, you'll need to up
the trust level of the public key:

```bash
gpg --edit-key <email>
# gpg> trust
# 5 # give it ultimate trust level
# gpg> save
```

### `passmenu`

You can call up passwords with `passmenu` (works with `dmenu`), try this out!

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

There are alternatives for `xmonad` and `rofi`. Look it up. There's also a
`pass` extension for `emacs`.

### Auto Login

When you log in, you will need to give your `gpg` password, you can solve this
by using [pam-gnupg](https://github.com/cruegge/pam-gnupg). This little program
is a PAM module that hands over your login password to `gpg-agent` (passes your
login password to "`gpg`", if your login password and your gpg key pair use the
same password, you won't need to enter it).

### OTP

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

### Security Tips

Set environment variables:

```bash
export GITHUB_TOKEN=$(pass show <file>)
```

This is useful for *not* inserting your passwords into your terminal session
(which is obviously ***a very bad idea*** since it can stay in your shell
history for a long time).

You should do the same thing for commands that require API tokens. Store them
in `pass`, do command substitutions and everything will be nice and secure.

Generally, anything that makes you not secure any of your credentials in plain
text is good.

### Extensions 

- there are `pass` browser extensions for Firefox and Chrome;
- GUI apps for all major OS's;
- apps for Android and MacOS;
- plugins to `pass` itself.
