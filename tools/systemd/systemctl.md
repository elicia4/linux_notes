# `systemctl`

Notes taken on the [Linux Crash Course - systemd: Using the systemctl
command](https://www.youtube.com/watch?v=5JVBpXiYMKo) video by LearnLinuxTV.

[***Table of Contents***](/README.md)

`systemd` is used in many Linux distributions.

Install `apache` as an example service to play around with.

On some distros, `apache` will be working right after installation finishes.
Enter `localhost` into your webbrowser to see if it did.

If you run `systemctl`, you will get a list of services that are running in the
background:

```bash
systemctl
```
    
To check the status of `apache`:

```bash
systemctl status httpd
```

If it says it's disabled, it means that it does not start on computer startup.

To enable:

```bash
sudo systemctl enable httpd 
```

It won't start immediatly, you will have to restart your machine, but what if
you can't? You can start the service manually:

```bash
sudo systemctl start httpd 
```

If you check the status again, it will be `active` and you will see logs at
the bottom.

You can also stop the unit:
    
```bash
sudo systemctl stop httpd 
```

You can start and enable at the same time:

```bash
sudo systemctl enable --now httpd    
```

To disable a unit:

```bash
sudo systemctl disable httpd 
```

You might want a particular unit to run only for a particular user. Install
Syncthing, which is a syncing utility. Check its status for a particular user:

```bash
sudo systemctl status syncthing@username
```

You can target a specific user by using `@username`:

```bash
sudo systemctl enable syncthing@username
```

Syncthing runs under port 8384. Check it in your webbrowser:

```bash
localhost:8384
```

If it doesn't run, it ok. The main thing is that it runs under a particular
user. 

Let's take a look at the `systemd` unit file for Syncthing:

```bash
cd /usr/lib/systemd/system; ls
```

There are quite a few services there, you need `syncthing@.service`:

```bash
sudo vim syncthing@.service
```

- `After` indicates that `syncthing` will run after `network.target`. 
- `User` is set to a variable, whatever you run it against. 
- `ExecStart` indicates what command to use to start a unit. 
- `Restart=on-failure` indicates that in case of failure, syncthing should
restart. 
- `WantedBy=multi-user.target` indicates that you want to run the program as a
user, meaning that you want it to run in the background, without GUI, the
alternative to this is `graphical.target`.(?) 

There are many other options.

A more graceful way to show all unit files:

```bash
systemctl list-unit-files --type=service 
```

It has a much better output. Vendor preset defines the default behaviour of
`systemd` (enabled/disabled). 

`restart` stops and then starts:

```bash
sudo systemctl restart httpd 
```

`reload` will keep the unit running but will enable all new settings
(will try to). `reload` is preferred, any time you can use it, do:

```bash
sudo systemctl reload httpd 
```
