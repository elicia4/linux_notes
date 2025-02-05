# `sar`

[Notes taken on the "Linux Crash Course - The sar Command" video by
LearnLinuxTV.](https://youtu.be/_4WVPSfGqos)

[***Table of Contents***](/README.md)  

NOTICE: The instructions might not work on your system, you might get only
`LINUX RESTART (X CPU)`. In this case, refer to the **FIX NOTE** at the end.

`sar` is "system activity reporter". It's useful for looking at historical 
performance values of your server. 

To install it:

```bash
sudo apt update; 
sudo apt install sysstat;
```

That's not enough, you have to customize the defaults:

```bash
sudo vim /etc/default/sysstat;
```

Set `ENABLED` to `"true"`. Make sure to restart the service:

```bash
sudo systemctl restart sysstat
```

Check out the `cron` file for `sysstat`:

```bash
cat /etc/cron.d/sysstat
```

Also take a look at:

```bash
cat /etc/sysstat/sysstat
```

It contains some additional configurations. 

By now, you should have a data file on your system right now:

```bash
ls -l /var/log/sysstat
```

If it's not there, wait for a few minutes, it runs every 10 minutes.

How do you run `sar`?

```bash
sudo sar -u -f /var/log/sysstat/sa22 # it's 22 because it's the 22nd day of
                                     # the month
```

It shows the date, the name of the image, and some system information at the
bottom. Make the terminal window smaller to see everything if information is
wrapped too much. You can see what the overall server usage was at any given 
time.

To show the current usage of the server:

```bash
sar -u
```

Take a look at the `%idle` column, it shows what percentage of the system is
idle.

To see information about memory:

```bash
sar -r 
```

To see information about swap:

```bash
sar -S
```

If your servers runs slow and you don't know why, see information about I/O:

```bash
sar -b
```

`sar` runs in the background and gathers useful data about your server
performance. It's useful for optimization and resource management.

### Network Statistics

To display network traffic:

```bash
sar [-n keywork] [ interval [ count ] ]
```

With the `DEV` keyword, statistics from the network devices are reported.

For example, the following command will output network statistics every second
5 times in total, it will print the average values at the end as well:

```bash
sar -n DEV 1 5
```

It displays the following parameters:

- `rxpck/s` - total number of packets received per second
- `txpck/s` - total number of packets transmitted per second
- `rxkB/s` - total number of kilobytes received per second
- `txkB/s` - total number of kilobytes transmitted per second

You can specify other protocols as well, such as:
> DEV, EDEV, FC, ICMP, EICMP, ICMP6, EICMP6, IP, EIP, IP6, EIP6, NFS, NFSD,
> SOCK, SOCK6, SOFT,  TCP, ETCP, UDP and UDP6.

### FIX NOTE

Check this out (thanks, Yvan):
https://serverfault.com/questions/1094466/sar-service-has-stopped-collecting-data

> So, if you're using systemd, you should reconfigure sysstat that will run
> through systemd and not through crontab:

```bash
dpkg-reconfigure sysstat
```

> Select "Yes".

> Editing /etc/default/sysstat directly (as I did until now) is a mistake: it
> doesn't update systemd files.

> Note that you'll see /etc/default/sysstat updated to ENABLED="true", but the
> cron won't run anymore (systemd will trigger it as expected).

> You can check everything is fine using:

```bash
systemctl status sysstat-collect.timer
systemctl status sysstat-summary.timer
```

> which should reply with «Active: active (waiting)»
