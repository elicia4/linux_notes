# `numfmt`

[***Table of Contents***](/README.md)

It's used to format numbers that quantify data storage:

```bash
echo '1024' | numfmt
echo '1024' | numfmt --to=si
echo '1024' | numfmt --to=iec
echo '1024' | numfmt --to=iec-i
```

```
1024
1.1k
1.0K
1.0Ki
```

It can also be used to format the output of your commands:

```bash
ls -l | numfmt --field=5 --format="~~~ %4f ~~~"
```

- `--format` specifies how the size quantity is represented
- `--field` specifies which columns are to be formatted

`--to=` can be used to represent the file size in different ways:

```bash
ls -l | numfmt --to=si --field=5 --format="~~~ %4f ~~~" # si
ls -l | numfmt --to=iec --field=5 --format="~~~ %4f ~~~" # iec
ls -l | numfmt --to=iec-i --field=5 --format="~~~ %4f ~~~" # two-letter iec
```

`numfmt` can also accept optional numbers as input:

```bash
numfmt --from=si --to=iec 1M
numfmt --from=si --to=iec 1048576
```

This can be useful to perform inline unit conversions:

```bash
numfmt --from=si --to=iec --format "%f ..." 1Z
numfmt --from=si --to=iec --format "%f ..." 1E
numfmt --from=si --to=iec --format "%f ..." 1P
numfmt --from=si --to=iec --format "%f ..." 1P
numfmt --from=si --to=iec --format "%f ..." 1T
```
