# `timeout`

[***Table of Contents***](/README.md)

You can use it to time out a command if it's been running for too long. Imagine
you have the following infinite loop:

```c
int main(){
    while(1){}
    return 0;
}
```

Compile & run it:

```bash
gcc infinite_loop.c -o infinite_loop
./infinite_loop
```

It will run forever... But if you run it with `timeout 3`, the program will
terminate after 3 seconds:

```bash
timeout 3 ./infinite_loop
```

A great example of timeout usage is file syncing. You can sync your files
during the night time:

```bash
# this command copies local files to a remote backup server
/usr/bin/rsync -avvv --progress --append-verify /my-important-files \
remote-backup-server:/backups/my-important-files
```

If the files are very large, this could run for multiple days and slow down
your network traffic for the entire duration. This is where `timeout` comes in
handy:

```bash
# now it only runs for 2 hours!
timeout 2h /usr/bin/rsync -avvv --progress --append-verify \ 
/my-important-files remote-backup-server:/backups/my-important-files
```

Then you can install the command as a cron job that runs every morning at 3AM:

```bash
1 3 * * * timeout 2h /usr/bin/rsync -avvv --progress --append-verify /my-important-files remote-backup-server:/backups/my-important-files
```

This way the back up operation will make a bit of progress every day and use
all of the networking capacity between 3AM and 5AM. Thus during the day, you
will have all the networking capacity you need!
