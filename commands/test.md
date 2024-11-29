# `test`

[***Table of Contents***](/README.md)

It can be used to test for file types and evaluate expressions.

To test for file types:

```bash
test -f file.txt # if a directory, returns 1
echo $?
test -f directory/ # if a directory, returns 1
echo $?
test -d directory/ # if a directory, returns 0
```

To evaluate expressions:

```bash
test 123 -eq 123
echo $? # 0 == success
test 123 -eq 125
echo $? # not 0  == failure
```

The result of the test is found in the return code. You can view it by
`echo`ing `$?`. Note that the return codes have the opposite meaning compared
to the traditional values found in Boolean logic.

`test` supports many other comparison operators, such as:

For integers:
- `-gt` - greater than
- `-lt` - less than
- `-le` - less than or equal
- `-ge` - greater than or equal

For strings:
- `-n` - non-zero string
- `-z` - zero length string
- `=` - equality check
- `!=` - non-equality check

Boolean operators:
- `-o` - logical OR
- `-a` - logical AND

E.g.:

```bash
test 123 -gt 123 -o 345 -eq 345
echo $?
```

The command can be built into the shell or it can exist as a standalone
executable:

```bash
type -a test
```
