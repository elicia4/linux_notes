# `cron`

Notes taken on [this video](https://youtu.be/7cbP7fzn0D8) by Learn Linux TV.

[**Table of Contents**](/README.md)

---

`cron` allows you to schedule tasks.

A *cron job* is a task scheduled with `cron`.

Every user on the system has their own set of `cron` jobs. A list of cron jobs
for a user is considered their **crontab**. To see the current user's crontab:

```bash
crontab -l
```

To view another user's crontab:

```bash
sudo crontab -u <user> -l
```

To set up a cron job:

```bash
crontab -e
```

You may be asked what text editor to use, you can automate this by setting the
`EDITOR` environment variable to your desired text editor: 

```bash
EDITOR=vim crontab -e
```

With this command, you're not *directly* editing the crontab, it's first going 
to have you work on the changes in the `/tmp` directory. Assuming that
everything is good, it's going to copy everything to the actual crontab.

Take a look at the comments inside the file, they can be useful whenever you
forget how to do something.

A cron job consists of 6 fields:

```
* * * * * command
```

Each individual field correlates to a time unit:

```
m h dom mon dow command
```

1. `m` - minute
2. `h` - hour 
3. `dom` - day of month
1. `mon` - month
4. `dow` - day of week
    
`*` means every. So `* * * * *` means every minute of every hour of every day
of every month on all days of the week. 

Let's say `m` is 5. What it means is that it's going to execute at **00:05**,
**01:05**, **02:05** and so on, so every time when a minute field equals 5.

What if you wanted your command to run every day at **9:05**?

```
5 9 * * * command
```

Every month every 15th day of the month at **9:05**?

```
5 9 15 * * command
```

Every August on the 15th day at **9:05**?

```
5 9 15 8 * command
```

Every August on the 15th, *only if that day is a Friday*, at **9:05**?

```
5 9 15 8 5 command
```

You can also run it hourly/daily:

```
@hourly command
@daily command
```

Run it at reboot:

```
@reboot command
```

It's not recommended to run cron jobs as your user. If you don't specify,
`crontab` commands will default to your user. 

It's better to segregate commands to a specific account or an account that
matches your purpose. For instance, if you have a webserver you're going to have
a user specific to it, so you should probably run commands from it. To edit a
crontab for a specific user:

```bash
sudo crontab -u <username> -e 
```

Let's run an `apt` command for example:

```bash
sudo crontab -ue root
```
```
* * * * * apt install -y tmux
```

To see the system log:

```bash
sudo cat /var/log/syslog
```

To see `cron` logs:

```bash
sudo cat /var/log/syslog | grep CRON
```

Let's redirect current time to a file every minute:

```
* * * * * date >> /root/date.txt
```
    
Now install Apache:

```bash
apt install apache2
```

You should now have a user called `www-data`:

```bash
cat /etc/passwd | grep www
```

Maybe you have some tasks that the web server has to run at some time
intervals.

Let's add a cron job to a `www-data` user. Switch to the account first:

```bash
sudo su - www-data
```

That won't work. That's because the shell for that user is set to `nologin`. To
fix the issue:

```bash
sudo crontab -u www-data -e
```

Imagine you have a website backup script. Add the following line to it:
 
```
0 3 * * * /usr/local/bin/website_backup.sh
```

Useful websites that can help with crontab:

```
https://crontab-generator.org/
https://crontab.guru/
```

That's it. :)
