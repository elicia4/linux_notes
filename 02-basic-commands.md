## Basic Commands

[***go back to README***](README.md)

Let's take a look at some basic commands.

You can use any package that contains a service file as an example but to
save time let's install Apache:

	sudo apt install apache2
	pacman -S apache
	...

To access apache, type `localhost` in your browser's address bar. 
It's likely that nothing appeared. That's because the service itself is not
running. To check the status of it:

	systemctl status httpd

To start it:

	systemctl start httpd

See if the page gets loaded again (drop the `s` from `https`). It should
work now.

To stop it:

	systemctl stop httpd

If you change the configuration of a service in some way and want them to
take effect, restart your service:

	systemctl restart <service>

To make a service run on system startup:
	
	systemctl enable <service>

To make a service NOT run on system startup:
	
	systemctl disable <service>

When you enable a service, a symlink will be created, don't be alarmed :)

There is additional information at the bottom of the `status` message, take a
look at if you experience problems with your services.

These commands are the bare minimum you need to know.
