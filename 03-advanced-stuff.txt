Let's take a look at how systemd is structured, more specifically let's take a
look at directories where unit files are stored.

systemd uses unit files. A unit files pertains to anything that systemd can
manage. systemd looks at files to figure out how it needs to interact with
processes. 

Service files are just text files that contain instructions that tell systemd
how to run those services.

Directories that are most common for service files are:

    /etc/systemd/system - the most common directory
    /run/systemd/system/ 
    /lib/systemd/system/ 

Take a look at the contents of this directory /lib/systemd/system/. There are
many different types of unit files in there, such as .target, .socket, .service,
.timer. Keep in mind that there are different types of unit files, not just
services.

Each one of the directories listed above has a specific purpose. You don't have
to create your own unit files since they mostly come preinstalled, they are 
located inside /lib/systemd/system/. Runtime systemd units are located inside 
/run/systemd/system/, you won't visit this directory often. The
/etc/systemd/system/ is the directory you will most commonly work with.

Priority of directories: /etc/systemd/system/ -> /run/systemd/system/ ->
/lib/systemd/system/. Higher priority unit files take priority over lower
priority unit files. If you put anything inside /etc... it will have utmost 
priority. You should put your own service files inside /etc/... to make sure the
service file is taken into account. Make sure to keep your service files in
/etc because if a package gets updated it can overwrite the unit files inside
the /lib/ folder.

Let's take a closer look at systemd unit files, specifically a service.

	vim /lib/systemd/system

The fact that the file is only readable is intentional. There are three 
sections: [Unit], [Service], [Install]. Each section is designated by square
brackets, the name of each section is capitalized, make sure to not change the
syntax because the file IS case-sensitive. 'Unit' with a lowercase 'u' doesn't
factor in. Systemd is expecting the first letter to be capital. Underneath each
section, you have the configurations for that section. Some of the fields are
required, some are optional.

The [Unit] section contains general information about the unit, for example a
Description which describes what the unit is for, next is Wants which indicates
what prerequisite units that must be started first, for example
'httpd-init.service'. Prerequisites should happen before that unit file has to
start up. It's common to have 'network.target', since many services want the
network to be available before the process starts. You can have many units
separated by spaces, in case you have more than one requirement, and the order
also matters, since the services will launch in order one after the other.
'After' inidicates what services will run after your service started. The
'Documentation' field indicates the documentation source for the unit.

The [Service] section has configuration options that are specific to service
files and these options configure how this unit is treated when it starts up.
The first option is 'Type', there are many types of 'Type', such as 'simple' or
'notify'. The 'simple' type is the default and is common, it causes systemd to
consider the service to be started up as soon as you start it. In contrast,
'notify' is the same except it's not configured to be running until the process
tells systemd that it's ready, whereas with 'simple' it's not gonna take that
into account and if you start it it's going to assume that it's running. You
generally shouldn't change that unless you have a very specific reason to do 
so. Types depend on design decisions made by the team that maintains the distro
you run. 'ExecStart', 'ExecReload' and 'ExecStop' do things when the process is
started, reloaded or stopped. But what is reload?..

Instead of restart, you can use reload:

	systemctl reload <service>

Reload is similiar to restart, but it's not a full restart of a service. Reload
will cause the process to reload its config files which enables a settings to
take effect without users getting disconnected. In the case of Apache this is
preferred, since you don't want your users to disconnect. Not every service
supports reload.

In the [Install] section there are configurations which happen when a unit file
is enabled or disabled. 'WantedBy' has to do with dependancy relationships. 
On Linux systems there are different run levels that define various operating
stages, multi-user.target indicates that the system must have reached a state
where multiple users can use the system at the same time, so in this case
Apache will not start until that stage has been reached.

This is a basic overview of the systemd service files.

To edit an existing service file:

	sudo systemctl edit httpd.service

You will be shown a file that's created as a part of the systemd edit command.
As you can see it's located at the /etc/... directory, that has to do with 
priority, YOUR config will have priority. The commented info is there to help
you. Try adding some info to the 'Unit' section's Description parameter by
uncommenting it, make it look like so:

	[Unit]
	Description=The Apache HTTP Server and it's awesome

This will not work. You have to make the configurations inside the specific
place in the edit file, there are two lines that indicated the place:

### Anything between here and the comment below will become the contents ...

### Edits below this comment will be discarded

 So if you want to edit, edit the file in that section and then take a look at
 it:

	cat /etc/systemd/system/httpd.service.d/override.conf

To undo the change, remove the override file:

	sudo rm /etc/systemd/system/httpd.service.d/override.conf

Another method of editing a service file:

	sudo systemctl edit --full httpd.service

This will have the full configuration for you in the service file. The '--full'
option tells systemd that you want to start with the full config option. The
package update changes will not change config files inside the /etc/... 
directory, so your files are safe there.

To reload your service with the new changes:

	sudo systemctl daemon-reload

If you don't do this the changes might not take effect. This command tells
systemd to take a look at its directories, look for anything that's changed
or is unique and load everything into memory. 

But what if you want to create your own unit files..?

Take a look at service files provided by developers. If you have a newer 
version of software that doesn't install a service file by default, take a look
at the software's github page and look for the service file there. Grab it as
an example and edit it to your needs.
