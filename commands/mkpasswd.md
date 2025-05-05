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
