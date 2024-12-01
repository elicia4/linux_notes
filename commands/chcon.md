# `chcon`

[***Table of Contents***](/README.md)

It's used to change the security context of a file:

```bash
ls -lZ foo.txt
chcon unconfined_u:unconfined_r:user_tmp_t:s0 foo.txt
ls -lZ foo.txt
```

It's only useful on systems that have SELinux installed.

Say you have an HTML document that's a part of your website:

```bash
pwd # /var/www/html
ls -lZ
cat index.html
# <html>
# Hello! Welcome to my page
# </html>
```

When you use `curl` to request this document through your web server, the
document is served successfully:

```bash
curl http://127.0.0.1/index.html
# <html>
# Hello! Welcome to my page
# </html>
```

However, if you create a new HTML document in `/tmp` and then move the document
to the web server's HTML folder, your web server will show a permissions error:

```bash
echo -e "<html>\nThis is my favorite web page.\n</html>" > /tmp/favorite.html
ls -lZ /tmp/favorite.html
sudo mv /tmp/favourite.html favourite.html
ls -lZ
cat favourite.html
curl http://127.0.0.1/favourite.html
# <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
# <html><head>
# <title>403 Forbidden</title>
# </head><body>
# <h1>Forbidden</h1>
# <p>You dont have permission to access this resource.</p>
# </body></html>
ls -lZ
```

In this case, the permission issue is caused by the new file security context:

```
... unconfined_u:object_r:user_tmp_t:s0 ... favourite.html
```

You can use `chcon` to directly change the file security context:

```bash
ls -lZ
chcon unconfined_u:object_r:httpd_sys_content_t:s0 favourite.html
ls -lZ
curl http://127.0.0.1/favourite.html
```

Now the web server can serve the web page successfully.

Security context changes that are made using `chcon` may be overwritten later
by other commands like `restorecon`:

```bash
ls -lZ
sudo chcon unconfined_u:object_r:user_tmp_t:s0 index.html
ls -lZ
sudo restorecon -vR /var/www/html
ls -lZ
```

`restorecon` restores default security context based on predefined rules:

```bash
sudo semanage fcontext -l | grep '/var/www/html'
```

Again, it's only useful for systems which have SELinux installed:

```bash
lsb_release -a # no SELinux
sudo chcon unconfined_u:unconfined_r:unconfined_t:s0 index.html
# chcon: invalid context: ...
```
