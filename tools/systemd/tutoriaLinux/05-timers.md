# Timers

[***go back to intro***](./01-intro.md)

There are many things you can use to schedule tasks in Linux. The famous one is
`cron`, but systemd has built-in timer functionality as well. 

There are too many implementations of `cron`. The majority of the enterprise 
systems have systemd on them, therefore they include systemd timers as well.

The analogous implementation of a cron timer using systemd timers consists of 
two files, a service file and a timer file.

An example of a cron job:

``` 
# m h dom mon dow command >> file.log
* * * * * * /usr/local/bin/task.sh >> /tmp/task.log
```

`task.sh` contains a simple executable script:

```bash
#!/usr/bin/env bash
echo "I just ran on $(date)"
exit 0
```

Systemd separates into two ideas: the timing information and the command. The 
logging bit (`>> /tmp/task.log`) becomes unnecessary due to the built-in
logging functionality of systemd.

Create a simple systemd service file `task.service`:

```
[Unit]
Description=Run the task

[Service]
ExecStart=/usr/local/bin/task.sh
```

Create a systemd timer file `task.timer`:

```
[Unit]
Description=task service timer

[Timer]
OnBootSec=0min
# the timing information (24-hour format)
# hour:min:sec
OnCalendar=*:*:0/30 
Unit=task.service

[Install]
WantedBy=multi-user.target
```

You can test a systemd timer:

```bash
systemd-analyze calendar "*:*:0/30"
```

You can now start the timer unit!

```bash
sudo systemctl daemon-reload
sudo systemctl start task.timer
# check the status of the timer
systemctl status task.timer
# follow the output of the service
systemctl -fu task.service
```

That's it (:

Check out the official documentation for timers!

    man systemd.timer
