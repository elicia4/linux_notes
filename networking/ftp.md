# The `ftp` command

[***Table of Contents***](/README.md)

`ftp` is a File Transport Protocol client, used for remote file transfer. Most
web browsers support it, it used to be the most popular method for file
transfer, you can often see URIs starting with `ftp://`. It's used to
communicate with FTP file servers. FTP is *not secure*, since it sends
credentials in ***cleartext***, meaning they are encrypted. For that reason,
almost all FTP done is done by *anonymous* servers. Anonymous servers allow one
to log in using the "anonymous" login and a meaningless password.

To connect to a fileserver:

    ftp <fileserver>

These are some of the commands you can issue while in the `ftp` client:
- `help` - show help
- `cd <directory>` - usual cd
- `ls` - usual ls
- `lcd Desktop` - change the directory on the *local machine* (the machine you
  connected from), in this case to `Desktop`
- `get <file>` - tell the remote system to transfer a particular file to the
  local system, it will get downloaded to the current local directory
- `bye`/`quit`/`exit` - log off and end the `ftp` program session

`lftp` is a good alternative to the default `ftp` client, it supports many
features not present in the regular `ftp`. It supports other protocols (e.g.
HTTP), tab completion of path names, automatic download retry and so on.

There is also an encrypted version of `ftp` called `sftp` that uses `ssh`
encrypted tunnels for transmissions. The remote server only needs to have `ssh`
installed for this to work, `ftp` is not required. Many file managers support
SFTP, like GNOME or KDE. You can enter a URI beginning with `sftp://` into the
location bar and operate on files stored on a remote system running an SSH
server.
