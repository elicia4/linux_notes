# Basic Website Setup Guide

[***Table of Contents***](/README.md)  

Sources by Luke Smith:
- https://youtu.be/OWAqilIVNgE
- https://landchad.net/

### Local Table of Contents

1. [Get a Domain Name](#get-a-domain-name)
1. [Get a Server](#get-a-server)
1. [Connect Your Domain and Server with DNS Records](#connect-your-domain-and-server-with-dns-records)
1. [Setting Up an NginX Webserver](#setting-up-an-nginx-webserver)
1. [Certbot and HTTPS](#certbot-and-https)

### Get a Domain Name

- Domain name - the name of a website that you type in an address bar, e.g.
`example.org`.
- Top-level domain (TLD) - the extension of a domain name, like `.com`, `.net`,
`.xyz`, etc.
- Registrar - a service authorized to reserve a domain name for you.

You need to buy a domain name from a registrar. There are many to choose from,
just buy a cheap one you like. You buy a domain name for a year. As long as you
pay the yearly fee, it's yours.

The purpose of a domain name is so that people don't have to remember your IP
address to find your website. In order to achieve this, you need to set DNS
settings that direct people connecting to your domain to your IP address.

### Get a Server

Get a VPS: 
- choose any hosting provider you like
- you don't need a lot of resources if you don't expect a lot of traffic
- it's possible to set up multiple websites & services on a single VPS
- as of early 2025 it's possible to get a small VPS for ~4 EUR or ~4.5 USD a
  month

Now set up an account and spin up a VPS: 
- choose Debian for the OS 
- do not choose IPv6 only

Note that if you will ever need more resource you can expand your resources
without data loss. 

If that's possible (and free), also enable *IPv6* and *block storage* for your
instance.

IPv6 is needed because it's important for future-proofing your website as more
of the web moves to the IPv6 protocol. Block storage is the ability to later
rent large storage disks to connect to your VPS. You just might want that as an
option, so it's worth activating now.

### Connect Your Domain and Server with DNS Records

Now that you have a domain and a server, you can connect the two using DNS
records. DNS (domain name system) records are usually put into your registrar
and direct people looking up your website to the server where your website and
other things will be.

1. get your IPv4/IPv6 addresses from your VPS provider 
1. put them into A/AAAA records respectively on your registrar 
    - create two entries for each IP if you have any subdomains (so two A
    records and two AAAA records)
    - one with your website & one with all subdomains
    - e.g., `.example.com` & `*.example.com`
1. wait for up 30 minutes, ping the domain name to check:

   ```bash
   ping <your domain name>
   host <your domain name> # will list both IPv4 & IPv6
   ```

1. once the pings go through, you're done!

Your hosting & registrar likely provide instructions on how to achieve this if
something goes wrong.

### Setting Up an NginX Webserver

First you need to connect to your terminal. The password & IP should be on your
VPS's page:

```bash
ssh root@<IP>
```

You will be prompted for a password, enter it. You should now be logged in as
root.

Since you have a domain name tied to your IPv4 address, you can connect with it
as well:

```bash
ssh root@<your domain name>
```

If it doesn't work, you might have set up the DNS settings wrong. 

Setting SSH settings at this point is recommended, specifically passwordless
authentication.

#### Nginx Configuration File

Now update your system & install `nginx`, a web server program:

```bash
apt update; apt dist-upgrade; apt install nginx
```

Now you need to create a page for `nginx` to display. 

`nginx` config files are stored in `/etc/nginx`. The two main subdirectories in
there are: 
- `/etc/nginx/sites-available` 
- `/etc/nginx/sites-enabled` 
The idea is that you can make a site configuration file in `sites-available`
and when it's all ready, you make a link/shortcut to it in `sites-enabled`
which will activate it.

First, create the settings for our website.

Create a file in `/etc/nginx/sites-available` by doing this:

```bash
vim /etc/nginx/sites-available/mywebsite
```
```
server {
        listen 80 ;
        listen [::]:80 ;
        server_name example.org ;
        root /var/www/mysite ;
        index index.html index.htm index.nginx-debian.html ;
        location / {
                try_files $uri $uri/ =404 ;
        }
}
```

- The `listen` lines tell `nginx` to listen for connections on both IPv4 and
IPv6 on port 80

- `server_name` is the website that we are looking for. By putting
`example.org` here, that means whenever someone connects to this server and is
looking for that address, they will be directed to the content in this block

- `root` specifies the directory we're going to put our website files in. This
can theoretically be wherever, but it is conventional to have them in
`/var/www/`. Name the directory in that whatever you want

- `index` determines what the "default" file is; normally when you go to a
website, say `example.org`, you are actually going to a file at
`example.org/index.html`. That's all that is. Note that that this in concert
with the line above mean that `/var/www/example/index.html`, a file on our
computer that we'll create, will be the main page of our website

- the `location` block is really just telling the server how to look up files,
otherwise throw a 404 error. Location settings are very powerful, but this is
all we need them for now

#### Create Directory & Index Site

Create a little page that will appear when someone looks up the domain. Create
a site directory and the index file in it:

```bash
mkdir /var/www/mysite
vim /var/www/mysite/index.html
```

Here's an example of what you might add, this will appear on your website:

```html
<!DOCTYPE html>
<h1>My website!</h1>
<p>This is my website. Thanks for stopping by!</p>
<p>Now my website is live!</p>
```

#### Enable the Site

Once you save that file, we can enable it making a link to it in
`sites-enabled`:

```bash
ln -s /etc/nginx/sites-available/mywebsite /etc/nginx/sites-enabled
```

Now we can just reload or restart to make `nginx` service the new
configuration:

```bash
systemctl reload nginx
```

#### Firewall

You will likely have a firewall program running on your machine, possibly
`ufw`. By default, it blocks everything. You need to enable HTTP (80) & HTTPS
(443):

```bash
ufw allow 80
ufw allow 443
```

Now everything should work!

#### Security

By default, `nginx` and most other webservers automatically show their version
number on error pages. It's a good idea to disable this from happening because
if an exploit comes out for your server software, someone could exploit it.
Open the main `nginx` config file `/etc/nginx/nginx.conf` and find the line:

```bash
# server_tokens off;
```

Uncomment it & reload `nginx`:

```bash
systemctl reload nginx
```

Always keep your server software up to date to get the latest security fixes!

#### Check your Website

It should now work. Insert the domain into your web browser. 

Note that the connection is not secure. Now you need to secure encrypted
connections to your website.

### Certbot and HTTPS

It is extremely important to enable encrypted connections over HTTPS/SSL.
Certbot is a program that automatically creates and deploys the certificates
that allow encrypted connections.

Install it:

```bash
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
```

Run it:

```bash
certbot --nginx
```

You will be prompted for an email. To disable the prompt, use the
`--register-unsafely-without-email` parameter.

After that is done, you will be asked what domains you want a certificate for.
Press 'Enter' to select all.

You will then be asked if you want to automatically redirect all connections to
be encrypted. Since this is preferable, choose 2 to Redirect.

You should now be able to go to your website and see that you are now on an
encrypted connection.

#### Certificate Renewal

Certbot certificates last for 3 months. To renew certificates, run:

```bash
certbot --nginx renew 
```

It will renew any certificates close to expiry.

Let's tell the server to automatically run this command with a cronjob:

```bash
crontab -e
```

Choose whatever editor you prefer.

`crontab` will open up a file for editing. A `crontab` is a list of commands
that your operating system will run automatically at certain times. We are
going to tell it to automatically try to renew our certificates every month so
we never have to.

Create a new line at the end of the file and add this content:

```
0 0 1 * * certbot --nginx renew
```

Save & exit to activate the cronjob.

You are now all done!
