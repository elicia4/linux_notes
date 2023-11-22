### Configuring SSH Server

[***go back to README***](README.md)  

So far, the notes were focused on the `ssh-client`, now we will focus on the 
server. 

You have to have the ssh server component running:

    which sshd

The `sshd` binary represents the server. `sshd` means ssh daemon. Check the
status of it with:

    systemctl status sshd

You can use all `systemctl` commands to manage the service. `restart`, `stop`,
do whatever you want. When you stop the `sshd` service it's not going to
terminate any connections that are existing. But if you disconnect, you won't
be able to reconnect since the `sshd` service has to be running in order to
establish new connections. Ubuntu and Debian call the binary `ssh`, not `sshd`.
To `start` and `enable` the service at the same time.

    systemctl enable --now sshd 

Take a look at the `/etc/ssh` directory. There are keys there stored for the 
fingerprints. When you copy images, ssh keys are copied along with them, and
you don't want all your servers to have the same ssh keys. Make sure to
regenerate them. 

The config you care about is `sshd_config`. 

To change the default port, change the `Port` value, you can change it to 2222
for example. 

You should disable root login, change `PermitRootLogin` to `no`, you ONLY want
to set it to `no` if you have another user you can log in with via ssh outside
of root. Root is going to be tried by anyone.

`PasswordAuthentication` is the most important security configuration change 
that you can possibly make with the ssh-server and EVERYBODY should set this to
`no`. You should only set this to `no` if you have an ssh key relationship
already set up, you wanna make sure that you log in with your ssh key BEFORE
you set this to `no`.

After configuration, restart the service and make sure the restart didn't
fail:

    systemctl restart sshd
    systemctl status sshd

Test the configuration change and make sure that ssh still works. You will
reconnect to it with the server's new settings. To connect with a different
port:

    ssh -p 2222 <username>@<destination>

If you don't include the `-p` option it will assume **22**.

Changing your port number to something other than 22 makes your server more
secure. There are bots that look for open 22 ports, when they find one they try
to get in. Your server will be spared :) Since `PasswordAuthentication` is 
disabled, password attacks are out of the question as well.

[Note that](https://unix.stackexchange.com/a/727500):

> Ubuntu/Debian distributions have the non-standard entry Include
> /etc/ssh/sshd_config.d/*.conf at the beginning of the distribution
> sshd_config. The purpose of this is to allow users to customize their sshd
> configuration without modifying the core sshd_config file, which can minimize
> conflicts or unexpected configuration changes on apt update of OpenSSH.

[***Go to Next Note***](07-troubleshooting-ssh.md)
