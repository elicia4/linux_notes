# `systemctl` commands

[***go back to README***](../README.md)

`systemctl` and `journalctl` (to interact with logs) are the two commands you
will use the most to interact with systemd.

`systemctl` has a bunch of subcommands:

    systemctl <subcommand> --options

If you just run `systemctl` by itself:

    systemctl

It will run the same command as:

    systemctl list-units

You can narrow the output:

    systemctl list-units --type=service # will output all of your services

If you want the full listing (the commands before only show active and
running), what you want is:

    systemctl list-unit-files

Let's take a look at commands that manage the state of units:

    # to show the current status of a unit 
    systemctl status <service>
    
    # to enable
    systemctl enable <service>

    # to disable 
    systemctl disable <service>

    # to start
    systemctl start <service>
    
    # to stop 
    systemctl stop <service>

There's an `ExecReload` command defined in the unit file. It executes whenever 
you run:

    systemctl reload <service>

If you:

    systemctl restart <service>

`systemd` will run `ExecStop` and the `ExecStart`. So a `restart` is a `stop`
and a `start`.

There's also `kill`(which kills the service):

    systemctl kill <service>

There are multiple unit statuses:

- Inactive (deactivating, exited)
- Active (activating, running)
- Failed
- Static (not started, frozen by systemd)
- Bad (broken), usually happens when your unit file is broken
- Masked, if you mask a unit, systemd will just ignore it, but it exists
- Indirect (disabled but referenced), disabled but another unit file references
  it so it could be activated
- Linked (symlinked)
