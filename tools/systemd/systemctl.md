# The `systemctl` command

Notes taken on the "Linux Crash Course - systemd: Using the systemctl command"
video by LearnLinuxTV.

[***Table of Contents***](/README.md)

`systemd` is used in many Linux distributions.

Install `apache` as an example service to play around with.

On some distros, `apache` will be working right after installation finishes.
Enter `localhost` into your webbrowser to see if it did.

If you run `systemctl`, you will get a list of services that are running in the
background:

    systemctl
    
To check the status of `apache`:

    systemctl status httpd

If it says it's disabled, it means that it does not start on computer startup.

To enable:

   sudo systemctl enable httpd 

It won't start immediatly, you will have to restart your machine, but what if
you can't? You can start the service manually:

   sudo systemctl start httpd 

If you check the status again, it will be `active` and you will see logs at
the bottom.

You can also stop the unit:
    
   sudo systemctl stop httpd 

You can start and enable at the same time:

    sudo systemctl enable --now httpd    

To disable a unit:

   sudo systemctl disable httpd 

You might want a particular unit to run only for a particular user. Let's
install Syncthing, which is a syncing utility. Install it. Enable it for a 
particular user:

    sudo systemctl status syncthing@username

You can target a specific user by using `@username`. Let's enable it for
`username`:

    sudo systemctl enable syncthing@username

Syncthing runs under port 8384. Check it in your webbrowser:

    localhost:8384

If it doesn't run, it ok. The main thing is that it runs under a particular
user. 

Let's take a look at the `systemd` unit file for Syncthing:

    cd /usr/lib/systemd/system; ls

There are quite a few services there. You need `syncthing@.service`. Take a
look at it:

    sudo vim syncthing@.service

The `After` parameter indicates that `syncthing` will run after
`network.target`. The `User` parameter is set to a variable, whatever you run
it against. The `ExecStart` parameter indicates what command to use to start a 
unit. The `Restart=on-failure` indicates that in case of failure, syncthing
should restart. There are many other options. `WantedBy=multi-user.target`
indicates that you want to run the program as a user, meaning that you want it
to run in the background, without GUI (???), the alternative to this is
`graphical.target`. 

A more graceful way to show all unit files:

    systemctl list-unit-files --type=service 

It has a much better output. Vendor preset defines the default behaviour of
systemd(enabled/disabled). 

Restart stops and then starts:

    sudo systemctl restart httpd 

The reload option will keep the unit running but will enable all new settings
(will try to). Reload is preferred, any time you can use it, do. 
