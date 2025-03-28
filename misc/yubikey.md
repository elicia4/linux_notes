# YubiKey

[Source](https://www.youtube.com/watch?v=INi-xKpYjbE)

It won't make you unhackable, but it will serve you as great 2FA.

YubiKey supports all three major OS's:
- Windows
- MacOS
- Linux

### What is a "YubiKey"?

- it's a security product developed by Yubico, their flagship product.
- hardware device that help secure online and computer accounts.
- devices that facilitate 2FA

How much benefit do Yubikeys provide?
- Although there's no such thing as perfect security, YubiKeys can make a HUGE
difference.
- Each model provides different features

Supported features: 
- FIDO
    - Supported by every YubiKey model
    - FIDO (Fast Identity / Universal Second Factor (U2F))
    - Developed by Yubico and Google
    - Universal standard for 2FA
- FIDO2
    - Passwordless evolution of FIDO
    - Can potentially replace passwords altogether
    - Supported by every Yubikey model
- NFC
    - Near Field Communication
    - Yubikeys are USB devices (lightning and USB-c are also available)
    - Alternative to USB
    - Not all models of Yubikey support this (note that of course your device
    has to support this as well)
- Biometric Access
    - Enables you to unlock your key with your fingerprint
    - Only the Yubikey Bio supports this
- OTP
    - One-time password
    - Used along with your usual credentials (password + username)
    - Utilizes a "counter" to help avoid replay attacks
- TOTP
    - Time-based OTP
    - Changes regularly based on time
    - Generally, the password changes every 30 seconds or so

### Which Model Should You Buy?

- There are many different ports, such as USB A and C, lightning etc.
- Also consider if you want NFC

4 Main Yubikey Categories:
- Security Key Series
- Yubikey 5 Series
- Yubikey Bio
- YubiHSM

Security Key Series:
- cheap
- minimalistic feature set
- no OTP, NFC, fingerprint reader

Yubikey 5 Series:
- start at a higher price point
- NFC are available
- no fingerprint reader

Yubikey Bio:
- only model with a fingerprint reader
- fewer features compared to 5 series
- most expensive
- recommended for desktops

YubiHSM:
- intended for infrastructure

NOTE:
- for Windows or MacOS, only Yubikey 5 series is supported
- Yubikey BIO for local authentication is supported on Linux
- you can use Yubikeys for online accounts

General Advice:
- check out the Yubico product matrix
- consider what devices you'll use
- check Yubico support catalog
- consider a spare/backup key

### Securing Online Accounts

You can secure:
- online accounts
- operating systems
- SSH (!!!)

First thing you should find out is whether or not your online account supports
a Yubikey:
[https://www.yubico.com/works-with-yubikey/catalog/?sort=popular](https://www.yubico.com/works-with-yubikey/catalog/?sort=popular)

Most sites don't do it right. There's usually a backdoor or a way for you to
restore your account. If that's the case, you might be better off not using
Yubikey at all.

### Linux 

1. You need a PAM module for U2F. If you use a Debian-based system, you're
   already good.
1. On Debian:

```bash
sudo apt update
sudo apt install libpam-u2f
mkdir ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys
# insert your yubikey
```

Next thing you should do is enable Yubikey for use with `sudo`:

```bash
sudo vim /etc/pam.d/sudo
# @include common-auth 
# auth required pam_u2f.so <-- add this line
```

After you execute a `sudo` command, e.g. `sudo apt update`, you will get a
blinking cursor after entering your password. It means that you need to
activate your Yubikey.

Next thing is to configure Yubikey authentication on login. For the GDM login
manager:

```bash
sudo vim /etc/pam.d/gdm-password
# @include common-auth 
# auth required pam_u2f.so <-- add this line
```

Now on login, after you enter your password your Yubikey will blink. Press it
and you will log in.

If somebody uses a TTY to log into your system, they will be able to. To enable
Yubikey on TTY:

```bash
sudo vim /etc/pam.d/login
# @include common-auth 
# auth required pam_u2f.so <-- add this line
```

You should be all good now. :)

### OpenSSH (FIDO2 Method)

FIDO2 method is preferred.

```bash
sudo apt update
sudo apt install libfido2-dev
ssh-keygen -t ed25519-sk -C "$(hostname)-$(date) +'%d-%m-%Y')-yubikey1"
# choose file path & passphrase
ssh-copy-id -i ~/.ssh/id_ed25519_sk.pub <host>
# now you can log in with your yubikey (wow)
ssh <host>
```

Now is a good idea to disable password authentication:

```bash
sudo vim /etc/ssh/sshd_config
# PasswordAuthentication no <- change from yes
sudo systemctl restart ssh # restarting ssh doesn't disrupt current sessions
# open a new terminal, just in case there's an error. You can fix stuff from
# the first terminal
```

### OpenSSH (Non-Fido2 Method)

On Debian:

```bash
sudo add-apt-repository ppa:yubico/stable
sudo apt update
sudo apt install libpam-yubico
vim /etc/ssh/authorized_yubikeys
# username:<press yubikey button><only keep first twelve characters>
# e.g.
# user:cccaaabbbddd
```

1. Now go to:
[https://upgrade.yubico.com/getapikey](https://upgrade.yubico.com/getapikey)
1. Enter your credentials
1. Get the API key (copy the "Secret key"). MAKE SURE THIS NEVER LEAKS OUT.
1. Now finish the configuration:

```bash
vim /etc/pam.d/sshd
# add new lines to the file, first non-comment line should be:
# auth required pam_yubico.so id=<client-id> key=<secret-key> authfile=/etc/ssh/authorized_yubikeys
vim /etc/ssh/sshd_config
# ChallengeResponseAuthentication yes <- change from "no"
# UsePAM yes <- make sure this is set
```
1. Restart `ssh`

```bash
# now restart ssh
systemctl restart ssh
# in a new window
ssh <host>
```

You're good to go!
