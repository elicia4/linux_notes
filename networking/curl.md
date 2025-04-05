# `curl`

Notes on [this video](https://www.youtube.com/watch?v=-nnJ82uc2ic) and various
other resources.

[***Table of Contents***](/README.md)

`curl` is a utility that allows you to transfer data to and from a server using
supported protocols. The protocols are: HTTP, HTTPS, FTP, FTPS, SFTP, TFTP,
Telnet etc.

It's a multi-platform tool, it works on Linux, MacOS and Windows.

It comes pre-installed with most distributions. Check if it's installed:

```bash
which curl
```

Install it:

```bash
# on a debian-based system
sudo apt install curl;
# OR on arch-based system
pacman -S curl;
```

On MacOS:

```bash
brew install curl
```

The most basic example is to pull something from a website, make sure you
specify the protocol:

```bash
# curl <URL>
curl https://kernel.org
```

You have the result in the terminal. You can output it to a file:

```bash
curl -o source.html https://kernel.org
```

While downloading the file, you get a status menu, it's fields are
self-explanatory.

Print it:

```bash
cat source.html
```

You can use `curl` to download files from the web:

```bash
curl -o ubuntu_server.iso \
https://releases.ubuntu.com/23.04/ubuntu-23.04-live-server-amd64.iso
```

To download a file with its original file name:

```bash
curl -O \
https://releases.ubuntu.com/23.04/ubuntu-23.04-live-server-amd64.iso
```

If a website is redirecting to another URL, you should specify that to `curl`.
It's mostly specified by the HTTP 300 or 303 requests.

If the server reports that the requested page has moved to a different location
(indicated with a Location:  header and a 3XX response code), the `-L` option
makes `curl` redo the request on the new place:

```bash
curl -L http://hsploit.com # if used without the -L option, curl will fail
```

You can query response headers. You can view and analyze the response headers 
being sent by a particular web server, this can help with web assessment:

```bash
curl -I https://hsploit.com
```

You can also view the request headers and the connection details:

```bash
curl -v https://hsploit.com
```

You can even see the TLS handshake in the output. This is a great way of
identifying problems with it.

You can test credentials, for example for a WordPress website:

```bash
curl --data "log=admin&pwd=password" https://wordpress.com/wp-login.php
```

You can play around with cookies and other things. It sends the specified data
in a POST request to the HTTP  server,  in  the  same  way  that  a browser
does when a user has filled in an HTML form and presses the submit button.

To see the help menu:

```bash
curl --help;
```

Or even better:

```bash
tldr curl
```

To see a very detailed description, refer to the `man` pages:

```bash
man curl
```

- use `-V` to check the version
- use `-s` to use silent mode:

```bash
curl -so source.html https://kernel.org
```

### Rest API

You can use `curl` with the `Rest API`. For example (not a real website):

```bash
curl https://example.com/api/2/employees/10
```

This is an example of a GET operation, it allows you to receive information
from a Rest API. You did not clarify that you were going to use the `GET`
operation, but it's used by default.

To `POST` information:
    
```bash
curl -d '{"name":"Jamie","age":"23","image":""}' -H \
'Content-Type:application/json' -X POST https://example.com/api/2/create
```

- `-d` allows you provide an argument with the data that you want to push to a
  Rest API. The information you push should be in a format that matches the
  target's format. 
- The POST verb allows users to push data to a Rest API and add new entries to
  a remote DB.
- `-H` informs the server that the data is in the `application/json` format. If
  you don't include the option, the result can be unexpected.

To modify an entry on a server:

```bash
curl -d '{"name":"Jamie","age":"23","image":""}' -H \
'Content-Type:application/json' -X POST https://example.com/api/2/update/31
```

- `-d` specifies the updated information;
- `-H` indicates the data format; 
- The ID of the record to update is included as part of the URI;
- `-X` includes the keyword, in this case it's `PUT`.

To delete information:

```bash
curl -X DELETE https://example.com/api/2/delete/31
```
