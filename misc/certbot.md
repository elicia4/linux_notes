# `certbot`

Source: https://certbot.eff.org/instructions?ws=nginx&os=snap

[***Table of Contents***](/README.md)

Certbot is a free, open source software tool for automatically using Let's
Encrypt certificates on manually-administrated websites to enable HTTPS.

The instructions are for Debian.

To make it work, first enable ports 80 and 443 (it can be done without doing
this, [check out this video](https://youtu.be/VjMRfF7hXIg)):

```bash
ufw allow 80
ufw allow 443
```

Install it:

```bash
snap install --classic certbot
```

Create a symbolic link for the executable:

```bash
ln -s /snap/bin/certbot /usr/bin/certbot
```

To to get a certificate AND edit your nginx configuration automatically to
serve it, turning on HTTPS access:

```bash
certbot --nginx
# for apache:
# certbot --apache
# you can additionally specify your domain with `-d <your domain>`
```

To just get the certificate:

```bash
certbot certonly --nginx
```

The Certbot packages come with a `cron` job or `systemd` timer that renew your
certificates automatically. You won't need to run Certbot again, unless you
change your configuration. To test automatic renewal:

```bash
certbot renew --dry-run
```

The command to renew `certbot` is installed in one of the following locations:

```bash
/etc/crontab/
/etc/cron.*/*
systemctl list-timers
```

You should be done now. You can also create your own cronjob that will be run
monthly:

```bash
crontab -e
```

Add the following:

```
0 0 1 * * certbot --nginx renew
```

Save & exit to activate the cronjob.

You can set up HSTS automatically with `--hsts`:

```bash
certbot --nginx --hsts -d <your domain>
```

What it does is "add the Strict-Transport-Security header to every HTTP
response. Forcing browser to always use SSL for the domain. Defends against SSL
Stripping."

###  Create an SSL Certificate Without Ports 80 and 443

Source: https://youtu.be/VjMRfF7hXIg

To install it:

```bash
certbot --manual --preferred-challenges dns certonly -d <your domain>
```

- `--preferred-challenges dns` - use DNS as a preferred challenge during
authorization
- `-d <your domain>` - specify your domain

Proceed as usual, agree to the IP log. You will then need to add a DNS TXT
record, add it (set the TTL to 1h or 3600s).

And you're done!

Note that you will need to renew it.

The paths to your certificate and key file will be presented at the end.
