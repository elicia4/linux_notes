# `case`

[***Table of Contents***](./00-contents.md)

For multiple-choice decisions, `bash` provides `case`:

```bash
case word in
    [pattern [| pattern]...) commands ;;]...
esac
```

With `case` you can turn this:

```bash
if [[ "$REPLY" == 0 ]]; then 
    echo "Program terminated." 
    exit 
fi 
if [[ "$REPLY" == 1 ]]; then 
    echo "Hostname: $HOSTNAME" 
    uptime 
    exit 
fi 
if [[ "$REPLY" == 2 ]]; then 
    df -h 
    exit 
fi 
if [[ "$REPLY" == 3 ]]; then 
    if [[ "$(id -u)" -eq 0 ]]; then 
        echo "Home Space Utilization (All Users)" 
        du -sh /home/* 
    else 
        echo "Home Space Utilization ($USER)" 
        du -sh "$HOME" 
    fi 
    exit 
fi
```

To this:

```bash
case "$REPLY" in 
    0)  echo "Program terminated." 
        exit 
        ;; 
    1)  echo "Hostname: $HOSTNAME" 
        uptime 
        ;; 
    2)  df -h 
        ;; 
    3)  if [[ "$(id -u)" -eq 0 ]]; then 
            echo "Home Space Utilization (All Users)" 
            du -sh /home/* 
        else 
            echo "Home Space Utilization ($USER)" 
            du -sh "$HOME" 
        fi 
        ;;
```

The `case` command looks at the value of `word`, which in our example, the
value of the `REPLY` variable, and then attempts to match it against one of the
specified `patterns`. When a match is found, the `commands` associated with the
specified pattern are executed. After a match is found, no further matches are
attempted.

The patterns used by `case` are the same as those used by pathname expansion.
Patterns are terminated with `)`:

- `a)` - matches if word equals "a"
- `[[:alpha:]])` - matches if word is a single alphabetic character
- `???)` - matches if word is exactly three characters long.
- `*.txt)` - matches if word ends with the characters ".txt"
- `*)` - matches any value of word. It is good practice to include this as the
last pattern in a `case` command, to catch any values of word that did not
match a previous pattern, that is, to catch any possible invalid values

```bash
case "$REPLY" in 
    [[:alpha:]]) echo "is a single alphabetic character." ;; 
    [ABC][0-9]) echo "is A, B, or C followed by a digit." ;; 
    ???) echo "is three characters long." ;; 
    *.txt) echo "is a word ending in '.txt'" ;; 
    *) echo "is something else." ;; 
esac
```

You can combine multiple patterns:

```bash
case "$REPLY" in 
    q|Q) echo "Program terminated." 
        exit 
        ;; 
```

### Performing Multiple Actions

In versions of bash prior to 4.0, case allowed only one action to be performed
on a successful match. After a successful match, the command would terminate.

For example, the character "a" is both lowercase and alphabetic, as well as a
hexadecimal digit. In bash prior to version 4.0 there was no way for case to
match more than one test. Modern versions of bash add the `;;&` notation to
terminate each action, so now we can do this:

```bash
case "$REPLY" in
    [[:lower:]])    echo "'$REPLY' is lower case." ;;&
    [[:alpha:]])    echo "'$REPLY' is alphabetic." ;;&
    [[:xdigit:]])   echo "'$REPLY' is a hexadecimal digit." ;;& 
esac
```

```bash
'a' is lower case.
'a' is alphabetic.
'a' is a visible character.
'a' is a hexadecimal digit.
```

With the `;;` notation, you would only get the first match:

```bash
'a' is lower case.
```

The addition of the `;;&` syntax allows case to continue to the next test
rather than simply terminating.
