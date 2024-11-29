# `date`

[***Table of Contents***](/README.md)

It's used to output the system date. You can also find the last modification
time of a file, set the time, etc. It also allows you to perform date-related
tasks:
- inserting date and time information into log files
- querying specific days of the year


By default, it prints the current date in the current time zone:

```bash
date
```

To see the date in UTC:

```bash
date --utc
```

Or you can explicitly specify a time zone:

```bash
TZ='America/Los_Angeles' date
TZ='Europe/Belgrade' date
```

To list time zones:

```bash
timedatectl list-timezones
```

To show the last modification time of a file:

```bash
date -r /etc/hosts
```

E.g., to find out if your ssh config has been updated:

```bash
date -r /etc/ssh/sshd_config
```

An example of embedding the command into other commands:

```bash
echo "$(date): Script has finished."
```

You can format the output: 

```bash
date +%m # prints the month
date +%H # prints the hour
date +%H # prints the hour
```

You can combine the options together:

```bash
echo "$(date "+%Y-%m-%d %H:%M:%S") - Script has finished."
# you need '+', Y - year, m - month, d - day, H - hour, M - minute, S - second
```

You can print out past dates:

```bash
date --date="10 days ago"
date --date="2 weeks ago"
date --date="15 minutes ago"
date --date="45 seconds ago"
```

It also lets you specify a date using the Unix time stamp:

```bash
date --date="@123123123"
date --date="@123123123" --utc
```

You can print out future dates:

```bash
date --date="50 years"
date --date="2 weeks"
```

Some common options:
- `%R` - 24-hour hour and minute; same as %H:%M
- `%s` - seconds since the Epoch (1970-01-01 00:00 UTC)
- `%S` - second (00..60)
- `%t` - a tab
- `%T` - time; same as %H:%M:%S
- `%u` - day of the week (1..7); 1 is Monday
- `%U` - week number of year, with Sunday as first day of week (00..53)
- `%V` - ISO week number, with Monday as first day of week (01..53)
- `%w` - day of week (0..6); 0 is Sunday
- `%W` - week number of year, with Monday as first day of week (00..53)
- `%x` - locale's date representation (e.g., 12/31/99)
- `%X` - locale's time representation (e.g., 23:13:48)
- `%y` - last two digits of year (00..99)
- `%Y` - year
- `%b` / `%h` - locale's abbreviated month name (e.g., Jan)
- `%H` - hour (00..23)
- `%I` - hour (01..12)
- `%j` - day of year (001..366)
- `%k` - hour, space padded ( 0..23); same as %_H
- `%l` - hour, space padded ( 1..12); same as %_I
- `%m` - month (01..12)
- `%M` - minute (00..59)
- `%n` - a newline
- `%N` - nanoseconds (000000000..999999999)
- `%p` - locale's equivalent of either AM or PM; blank if not known
- `%P` - like %p, but lower case
- `%q` - quarter of year (1..4)
- `%r` - locale's 12-hour clock time (e.g., 11:11:04 PM)

And other possible options, they can be found on the `info` and `man` pages:

```bash
man date
info date
```

You can set the date and time with `date` as well. It's a better idea to rely
on time sync (NTP servers, built-in time sync, etc.)

...but you can do it anyway if you want to:

```bash
sudo date --set="20240808 11:11"
```

Another example of using the date command in a script:

```bash
echo "The current date and time is: $(date)."
```

Do you want to find out what week day you were born on? :)
Imagine you were born on the 11th of November, 2011.

```
date +%A -d "2011-11-11"
```
