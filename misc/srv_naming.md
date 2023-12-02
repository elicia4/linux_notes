# Server Naming

Notes taken on the "Demystifying Hostnames and Domain Names in Linux, and How
Server Naming Benefits You" video by LearnLinuxTV.

[***Table of Contents***](/README.md)

Hostnames and domain names will be discussed in general terms.

Whenever you set up a server or a workstation, you will be prompted for what to
name the server. Don't settle for the default name, come up with a good name or
even for a naming scheme in case you have many servers. If you have many
servers named the same way, it will be hard to differentiate between them. For
example, you might have the following servers:

- gitlab
- nextcloud
- db-server
- webserver

These names are self-explanatory and good.

All Linux servers have a hostname. To see it:

    hostname

### What is a "hostname"?

- The hostname is the server's base name
- You can come up with your own hostnames for your servers
- Consider having your own naming schemes (mythological creatures and stuff)

### What are "domain names"?

- A domain name is a reference to an IP address
- There's additional functionality you can benefit from by setting up domain
  names
- It's quite common to apply a domain to a web site

### Name Surname analogy

Think of hostnames as first names and domain names as surnames. A Linux
server's name could be `webserver.learnlinux.tv` or `db.learnlinux.tv`. The
hostnames are `webserver` and `db`, the domain name is `learnlinux.tv`. The
full name (hostname + domain name) is called a fully qualified domain name,
typically written as `hostname.domain.tld`. 

### DNS

When a company has a web server, they are looking for requests, if a request
comes for a domain name or a website name that the server is responsible for,
it will accept that request and serve the webpage. It doesn't matter to the
user if they connected to `webserver1.learnlinux.tv` or
`webserver2.learnlinux.tv`, all the user cares about is that they get to the 
website that they're trying to access.

The way that this typically works is you have an "A" record or an address
record or a DNS entry, DNS itself is fundumentally just a mapping between an IP
address and a domain name. When you type `learnlinux.tv` in your browser, what
your browser does is issue a DNS lookup request for `learnlinux.tv`, it's
looking for the A record and whatever IP address that corresponds to that A
record is what's going to be served to the user. You can test that out
yourself:

    nslookup learnlinux.tv

### Differences between hostnames and domain names

Domain names, unlike hostnames, are optional. You don't have to have a domain 
name applied to any server at all, but hostnames are required. 

The domain is the namespace, the hostname is the individual name of that
particular server, it's possible that you will run into two different clients
whose servers have the same hostname.

### Domain Controller

- A domain controller can be useful, but it's not required
- Windows domain controllers are very common and many organizations use them

...but if it's not required, why do people use it so often? A domain controller
is a server that manages a domain and controls how it's used, it controls how a
domain is used and how resources within that domain are assigned. The most
common domain controller is Microsoft Active Directory(AD). It can simplify how
your domain is managed and give you additional functionality, but it's just
that, added functionality. Depending on how many servers you have within your
network, implementing a domain controller might work against you, it might
represent an additional administrative burden that can create unnecessary work.
If you have only 5 or 6 servers, you probably shouldn't set up a domain
controller.
