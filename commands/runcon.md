# `runcon`

[***Table of Contents***](/README.md)

Run a command within a specified security context: 

```bash
runcon -t unconfined_t date
```

Only works on systems that have SELinux installed.

Say you have a script that uses parameters. If a reverse shell is injected into
that, you would get compromised. To fix that, you can run your commands inside
preconfigured security contexts:

```bash
runcon
ls -Z script.sh
runcon -t user_home_t ./script.sh "echo This is my favorite message'!'" 
# This is my favorite message
runcon -t user_home_t ./script.sh 'printf "How are you today?\n"' 
# How are you today?
runcon -t user_home_t ./script.sh 'nc -l 0.0.0.0 1337 -e /bin/bash' 
# ./script.sh: fork: Permission denied
```

Unlike the default security context, this new security context doesn't allow
process forking, causing the reverse shell injection to fail.

You can specify a colon (`:`) separated security context or specify the user,
role, type and range individually:

```bash
runcon unconfined_t:unconfined_r:user_home_t:s0 ./script.sh
runcon -u unconfined_t -r unconfined_r -t user_home_t -l s0 ./script.sh
```
