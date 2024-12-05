# `false`

[***Table of Contents***](/README.md)

Does absolutely nothing and exits unsuccessfully:

```bash
false
echo $? # 1 - unsuccessful return code
```

It can be built into the shell or exist as a regular executable:

```bash
type -a false
```

Can be used to deny users the ability to access a shell environment. E.g:

```bash
cat /etc/passwd | grep postgres # uses /bin/bash by default
cat /etc/passwd | grep /bin/false # see what services use /bin/false
```

If you try to log in as one of those users (with `/bin/false` set), you will
fail:

```bash
sudo -u postgres -i # /bin/bash, the shell launches
sudo -u tomcat -i # /bin/false, fails immediately
# -i - run the shell specified by the target user's password database entry as
# a login shell. 
```
