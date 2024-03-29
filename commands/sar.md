# The `sar` command

Notes taken on the "Linux Crash Course - The sar Command" video by
LearnLinuxTV.

[***Table of Contents***](/README.md)  

NOTICE: The instuctions might not work on your system, you might get only
`LINUX RESTART (X CPU)`. In this case, refer to the **FIX NOTE** at the end.

`sar` is "system activity reporter". It's useful for looking at historical 
performance values of your server. 

Install it first:

    sudo apt update; 
    sudo apt install sysstat;

That's not enough, you have to customize the defaults:

    sudo vim /etc/default/sysstat;

Set `ENABLED` to `"true"`. Make sure to restart the service:

    sudo systemctl restart sysstat

Check out the `cron` file for `sysstat`:

    cat /etc/cron.d/sysstat

Also take a look at:

    cat /etc/sysstat/sysstat

It contains some additional configurations. 

By now, you should have a data file on your system right now:

    ls -l /var/log/sysstat

If it's not there, wait for a few minutes, it runs every 10 minutes.

How do you run the `sar` command?

    sudo sar -u -f /var/log/sysstat/sa22 # it's 22 because it's the 22nd day of
    # the month

It shows the date, the name of the image, and some system information at the
bottom. Make the terminal window smaller to see everything if information is
wrapped too much. You can see what the overall server usage was at any given 
time.

To show the current usage of the server:

    sar -u

Take a look at the `%idle` column, it shows what percentage of the system is
idle.

To see information about memory:

    sar -r 

To see information about swap:

    sar -S

If your servers runs slow and you don't know why, see information about I/O:

    sar -b

The `sar` command runs in the background and gathers useful data about your
server performance. It's useful for optimization and resource management.

### FIX NOTE: 
Check this out (thanks, Yvan):
https://serverfault.com/questions/1094466/sar-service-has-stopped-collecting-data

> So, if you're using systemd, you should reconfigure sysstat that will run
> through systemd and not through crontab:

    dpkg-reconfigure sysstat

> Select "Yes".

> Editing /etc/default/sysstat directly (as I did until now) is a mistake: it
> doesn't update systemd files.

> Note that you'll see /etc/default/sysstat updated to ENABLED="true", but the
> cron won't run anymore (systemd will trigger it as expected).

> You can check everything is fine using:

    systemctl status sysstat-collect.timer
    systemctl status sysstat-summary.timer

> which should reply with «Active: active (waiting)»
