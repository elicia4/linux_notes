# `systemd` Timers

Notes taken on the "Automate Your Tasks with systemd Timers: A Step-by-Step
Guide" video by LearnLinuxTV.

[***go back to README***](/README.md)

### Overview

- Timers in systemd are similiar to cron jobs: You can use them to schedule
  tasks.
- systemd timers are great, but cron jobs can be more effective in some
  situations.
- systemd timers are a part of systemd. cron jobs are more universal.
- Compared to cron jobs, systemd timers have additional features.
- Typically, cron jobs are faster to implement than systemd timers.
- While configuring timers, there's a bit of overlap with typical systemd
  commands.

Q: When should you use cron jobs, and when should you use systemd timers?  
A: One will be a better fit than the other, so use whatever fits in naturally.

- The task you run won't perform better when launched with either one of these.
- Systemd timers require systemd, so your distro will need to feature systemd
  itself. 
- If your project is time-sensitive, go with cron jobs.
- If you need to utilize advanced scheduling features, go with systemd timers.

### Sample project overview

Imagine you have a web server and you want to send the motd to your users on a
regular schedule. We will look at how we can achieve that with a systemd timer.

The first thing you should do is test out the command that you want to
schedule. You need to make sure that the command you want to run is the command
that works in the first place. Use the `wall` command to send out the message 
to the users that are logged into your system:

    wall "Hello World"

Every user logged in into the system should see the message. Let's make it a
bit more fun:

    curl wttr.in?format=3

This command should show the current weather. Combine it with `wall`:

    wall $(curl wttr.in?format=3)

`$()` is a subshell. 

### Implementing a systemd timer

Create two unit files:

    touch weather-report.service weather-report.timer

Both timers are services are types of units. 

Add the following text to the `weather-report.service` file:

    # In this section we define the Unit itself
    [Unit]
    # We give it a description
    Description=Weather Report Service
    # We want to start after "network-online". The system can't
    # pull the weather report if the system is offline.
    After=network-online.target
    # We want to start after "network-online"
    Wants=network-online.target

    # The service section
    [Service]
    # The command that will be executed when the unit starts
    ExecStart=/bin/sh -c 'wall $(curl wttr.in?format=3)'

    [Install]
    # the default.target is setting up the environment /
    # settings and options that will go into the service file.
    # You can think of this as inheritance.
    WantedBy=default.target

Add this text to the timer file:

    [Unit]
    Description=Weather Report Service
    
    # The timer section
    [Timer]
    # OnCalendar tells the timer when it should trigger
    OnCalendar=Mon..Fri 10:00
    
    [Install]
    # Similiar to default.target, but it's timers instead
    WantedBy=timers.target

What is the relationship between these two files? How does the timer know what
it's supposed to be doing? Both of these files have the exact same name, the
only exception being the extension. When the timer triggers, it looks for a 
service file of the same name, that's how it knows which one it's supposed to
execute. When it finds it, it starts it, it's not that different when you start
it yourself.

Make `root` the owner of the service and timer files:

    sudo chown root:root weather-report.service weather-report.timer

Install the service file:

    sudo mv weather-report.service /etc/systemd/system/

Confirm that it's there:

    ls -l /etc/systemd/system/weather-report.service

Let systemd know that you made a change to a unit file:

    sudo systemctl daemon-reload 

`daemon-reload` will scan the directories and see what's changed. Check the
service file:

    systemctl status weather-report.service

It should be loaded. It's not running, it's supposed to run once and quit. To 
prove that it works:

    sudo systemctl start weather-report.service

It should have given you the weather report. Now you know that the service file
works.

Take another look at the timer file. There's no command listed there, the
service file has the command that you're going to use. The service file is not
mentioned either because of the reason mentioned above.

Install the service file:

    sudo mv weather-report.timer /etc/systemd/system/

You should now have both:

    ls -l /etc/systemd/system/weather-report.*

You should a `daemon-reload` again:

    sudo systemctl daemon-reload 

Check the `status`:

    systemctl status weather-report.timer 

Enable the timer:

    sudo systemctl enable weather-report.timer;
    systemctl status weather-report.timer 

Now it's enabled. Now start the `timer`:

    sudo systemctl start weather-report.timer;
    systemctl status weather-report.timer 

Under `Trigger` it's going to tell you when it will trigger next time.

You want to both `enable` and `start` the timer. You don't have to do anything
with the `service` file, not even enable it. If you enable it, it will run at
boot time. The presence of a timer doesn't change how the service behaves.

So far everything you've done with systemd timers can be done with cron jobs.

### Additional Options

Let's add additional options to the timer file.

    [Unit]
    Description=Weather Report Service
    
    [Timer]
    # You don't have to use seconds. This ensures that the server has to run at
    # least 15 minutes before the timer will trigger. It ensures that the timer
    # doesn't get in the way of other services.
    OnBootSec=15m
    OnCalendar=Mon..Fri 12:51
    # If you restart your server and the weather-report triggers at that time,
    # it will still run at the next available opportunity, in this case, when
    # the server starts up the next time.
    # If a job is missed, it will run at the next available opportunity.
    Persistent=true
    
    [Install]
    WantedBy=timers.target

Let's examine the `OnCalendar` option. How does one come up with a time frame
that `systemd` will understand? Type a simple timestamp:

    Monday 2032-08-16 00:32:40

This is a format that systemd understands. This time will execute at that
single day at that exact time and never again. You can substitute these entries
with `*`, asterisk means "any":

    # the timer will trigger at this date and time regardless of the day of the
    # week.
    * 2032-08-16 00:32:40
    # the timer will trigger at this date and time regardless of the day of the
    # week and the year.
    * *-08-16 00:32:40
    # the timer will trigger at this date and time regardless of the day of the
    # week, the year, and the month.
    * *-*-16 00:32:40
    # the timer will trigger every day at that exact time regardless of the day
    # of the week, the year, the month, and the day.
    * *-*-* 00:32:40
    # ...and so on and so on.
