# The `curl` command

Notes taken on the "Supercharge Your Workflow with cURL | Understanding The
cURL Command-Line Tool" video by LearnLinuxTV, "Linux Essentials: Curl
Fundamentals" by HackerSploit, and the `curl` man page.

[***Table of Contents***](/README.md)

`curl` is a utility that allows you to transfer data to and from a server using
supported protocols. The protocols are: HTTP, HTTPS, FTP, FTPS, SFTP, TFTP,
Telnet etc.

It's a multi-platform tool, it works on Linux, MacOS and Windows.

It comes pre-installed with most distributions. Check if it's installed:

    which curl

Install it if it's not, on Linux:

    sudo apt install curl;
    # OR
    pacman -S curl;

On MacOS:

    brew install curl

The most basic example is to pull something from a website, make sure you
specify the protocol:

    # curl <URL>
    curl https://kernel.org

You have the code for the website in the terminal. You can output that to a
file:

    curl -o source.html https://kernel.org

While downloading the file, you get a status menu, it's fields are
self-explanatory.

`cat` it out:

    cat source.html

You can use `curl` to download files from the web:

    curl -o ubuntu_server.iso \
    https://releases.ubuntu.com/23.04/ubuntu-23.04-live-server-amd64.iso

To download a file with its original file name:

    curl -O \
    https://releases.ubuntu.com/23.04/ubuntu-23.04-live-server-amd64.iso

If a website is redirecting to another URL, you should specify that to `curl`.
It's mostly specified by the HTTP 300 or 303 requests.

If the server reports that the requested page has moved to a different location
(indicated with a Location:  header and a 3XX response code), the `-L` option
makes `curl` redo the request on the new place:

    curl -L http://hsploit.com # if used without the -L option, curl will fail

You can query response headers. You can view and analyze the response headers 
being sent by a particular web server, this can help with web assessment:

    curl -I https://hsploit.com

You can also view the request headers and the connection details:

    curl -v https://hsploit.com

You can even see the TLS handshake in the output. This is a great way of
identifying problems with it.

You can test credentials, for example for a WordPress website:

    curl --data "log=admin&pwd=password" https://wordpress.com/wp-login.php

You can play around with cookies and other things. It sends the specified data
in a POST request to the HTTP  server,  in  the  same  way  that  a browser
does when a user has filled in an HTML form and presses the submit button.

To see the help menu:

    curl --help;

Or even better:

    tldr curl

To see a very detailed description, refer to the `man` pages:

    man curl

- use `-V` to check the version
- use `-s` to use silent mode:

    curl -so source.html https://kernel.org

### Rest API

You can use `curl` with the `Rest API`. For example (not a real website):

    curl https://example.com/api/2/employees/10

This is an example of a GET operation, it allows you to receive information
from a Rest API. You did not clarify that you were going to use the `GET`
operation, but it's used by default.

To `POST` information:
    
    curl -d '{"name":"Jamie","age":"23","image":""}' -H \
    'Content-Type:application/json' -X POST https://example.com/api/2/create

- `-d` allows you provide an argument with the data that you want to push to a
  Rest API. The information you push should be in a format that matches the
  target's format. 
- The POST verb allows users to push data to a Rest API and add new entries to
  a remote DB.
- `-H` informs the server that the data is in the `application/json` format. If
  you don't include the option, the result can be unexpected.

To modify an entry on a server:

    curl -d '{"name":"Jamie","age":"23","image":""}' -H \
    'Content-Type:application/json' -X POST https://example.com/api/2/update/31

- `-d` specifies the updated information;
- `-H` indicates the data format; 
- The ID of the record to update is included as part of the URI;
- `-X` includes the keyword, in this case it's `PUT`.

To delete information:

    curl -X DELETE https://example.com/api/2/delete/31
