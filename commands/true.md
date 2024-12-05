# `true`

[***Table of Contents***](/README.md)

It does nothing and then exits successfully (returns the successful return
code, '0'):

```bash
true
echo $?
```

It can be built into the shell or exist as a regular executable:

```bash
type -a true
```

`true` is useful whenever you must specify a program that should exit
successfully. E.g.:

```bash
while /bin/true; do echo 'Hello World'; sleep 1; done # it prints forever
```

`while` will continue to run the loop as long as the command exits
successfully. That's exactly what `true` always does.
