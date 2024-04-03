# Time Zones on Linux 

[***Table of Contents***](/README.md)  

### `timedatectl`

To check the current time zone:

```bash
timedatectl
```

The system time zone is configured by symlinking the `/etc/localtime` file to a
binary time zone's identifier in the `/usr/share/zoneinfo` directory.

Another way to check the time zone is to view the path the symlink points to:

```bash
ls -l /etc/localtime
```

To view a list of available time zones:

```bash
timedatectl list-timezones
```

Once you find the time zone you need, set it:

```bash
sudo timedatectl set-timezone Europe/Lisbon
```

To verify your change:

```bash
timedatectl
```
