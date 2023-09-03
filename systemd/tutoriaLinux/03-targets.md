# Targets

[***go back to intro***](./01-intro.md)

Targets are a way of managing relationships between all the units you have.
Targets are a way of having managable system phases during boot that you can
order all those units under. It helps make unit management easier.

Targets are a good way of grouping units together. They figure out dependencies
for you. As the system boots, it will go through successive stages where 
different targets have been reached, each target implies all of the services 
that that target wants are up.

To take a look at active and loaded targets:

    systemctl list-units --type=target

`multi-user.target` is the end state, it's the last one that gets reached in
general. You can create custom ones that get reached after that. It means that
everything is up and multiple users are ready to log in.

The networking ones are `network-online.target`, `network-pre.target`, and
`network.target`. You might want `network-pre.target` before the network starts
coming up to munch some of the device and hardware config stuff. You can switch
between targets with:

    systemctl isolate <target>

It would stop a lot of stuff and get you back to the `<target>` state. You can
move between targets if you want to, but it is rarely used. 

To list ALL the targets:

    systemctl list-units --type=target --all

The `rescue.target` starts a minimum number of services, just enough to make 
your machine troubleshootable. You fix some stuff and see if it works without
rebooting.

To see what your system tries to get to when it starts:

    systemctl get-default

To enable a particular service for a target (you don't want to use this):

    systemctl add-wants multi-user.target nginx.service

This is another way of autostarting your service before the target is reached.
Do these things in your unit files, it's a terrible practice to do it here.
It's hard to troubleshoot in case you need to test your system, it's a bad
practice overall.

A cool way to shutdown your machine:

    systemctl isolate poweroff.target    
