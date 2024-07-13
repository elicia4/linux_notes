# Hostname

Notes on the video "Linux Crash Course - Setting the Hostname of your Linux
Workstation or Server" by LearnLinuxTV.

[***Table of Contents***](/README.md)  

Depending on how you have your shell configured, the hostname of your machine 
will be displayed right in the bash prompt. In case it's not, to display it:

```bash
hostname
```

The hostname is stored in `/etc/hostname`:

```bash
cat /etc/hostname
```

Another file that exists on your system is `/etc/hosts`:

```bash
cat /etc/hosts
```

It may contain various domains your server may be known as. If you have a
hostname, you want it to be in this file. This is where you tell the server how
to respond to its own name.

`hostname` by itself gives you a fully qualified domain name (FQDN), `hostname
-a` only gives you the hostname (?). `hostname -A` gives you the domain name:

```bash
hostname
hostname -a
hostname -A
```

Another way to get the FQDN:

```bash
hostname -f
```

To get IP information associated with the hostname:

```bash
hostname -I
```

Let's take a look at a special command:

```bash
hostnamectl # hostname control
```

This command if part of `systemd`.

By itself, it will give you some system information. It can be used to change
the hostname as well:

```bash
sudo hostnamectl set-hostname new_hostname
```

It won't be displayed immediately in the prompt since your terminal window had
been opened before you changed the hostname. You can relaunch it or open a new
tab to see a new one in the prompt, or just force it along:

```bash
exec bash
```

Take a look at the `/etc/hostname` file again to confirm:

```bash
cat /etc/hostname
```

You can change it to a domain too:

```bash
sudo hostnamectl set-hostname new-hostname.domain.com
```

Take a look at the `/etc/hosts` file. It does not update automatically, you do
that manually:

```bash
sudo vim /etc/hosts
```

Add a new line:

```bash
127.0.1.1  newhostname
```

Do this is if it's only just a hostname. If you have a domain, type that there
as well and a shortened version like so:

```bash
127.0.1.1  newhostname.domain.com newhostname
```

You should be able to ping the domain name now:

```bash
ping newhostname.domain.com 
```

...and the shortened name too:

```bash
ping newhostname 
```
