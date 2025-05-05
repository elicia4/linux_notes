# `mkpasswd`

[***Table of Contents***](/README.md)

`mkpasswd` encrypts the given password with the crypt function, using
the given salt.

To encrypt a string `PASSWORD`:

```bash
mkpasswd PASSWORD
```

By default, `yescrypt` is used for encryption.

- `-m` - specify a method (`-m help` prints all available ones):
- `-s` - read string from STDIN (0 fd).

```bash
# SHA-512
echo PASSWORD | mkpasswd -s -m sha512crypt
# yescrypt
echo PASSWORD | mkpasswd -s -m yescrypt
```

`-S` to specify a salt:

```bash
mkpasswd -m yescrypt -S SALT PASSWORD 
```

Alternatively, the salt can be specified after the password (without `-S`):

```bash
mkpasswd -m sha512crypt PASSWORD SALT 
```

`-R` to specify the number of rounds:

```bash
mkpasswd -m sha512crypt -R 10000 PASSWORD SALT 
```

If you run it with no arguments, it will prompt for a password:

```bash
mkpasswd
```

It's also possible to generate a password with `openssl`:

```bash
openssl passwd -6 # SHA512 
```

### Setting a Hash for a User

You can pass a password hash to `usermod` to set a new password:

```bash
# usermod -p 'HASH' USER
usermod -p '$y$j9T$Jv/IKJguqNawd6zBuXdp10$xfFT7jl3ayQYz11st..nw.K.0dHISXDcmN.Fu/QUa.A' username
```

Check if it's set:

```bash
grep username /etc/shadow
```
