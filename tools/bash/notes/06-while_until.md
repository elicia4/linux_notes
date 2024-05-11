# Looping with `while` / `until`

[***Table of Contents***](./00-contents.md)

Looping allows parts of your scripts to repeat. 

### `while`

To repeat an action *while* a condition is true:

```bash
count=1

while [[ "$count" -le 5 ]]; do 
    echo "$count" 
    count=$((count + 1)) 
done
```

The syntax is:

```bash
while commands; do commands; done
```

### Breaking Out of a Loop

Use: 
- `break` to immediately break out of a loop
- `continue` to skip the remainder of an iteration of a loop, and resume with
the next iteration

### `until`

To repeat commands *until* a condition is true: 

```bash
until commands; do commands; done
```

```bash
count=1 

until [[ "$count" -gt 5 ]]; do 
    echo "$count"
    count=$((count + 1)) 
done
```

### Reading Files with Loops

`while` and `until` can process STDIN. With redirection:

```bash
#!/bin/bash 

# while-read: read lines from a file 

while read distro version release; do 
    printf "Distro: %s\tVersion: %s\tReleased: %s\n" \ 
        "$distro" \ 
        "$version" \ 
        "$release"
done < distros.txt
```

With piping:

```bash
#!/bin/bash 

# while-read2: read lines from a file 

sort -k 1,1 -k 2n distros.txt | while read distro version release; do
    printf "Distro: %s\tVersion: %s\tReleased: %s\n" \ 
        "$distro" \ 
        "$version" \ 
        "$release"
done
```

It is important to remember that since a pipe will execute the loop in a
subshell, any variables created or assigned within the loop will be lost when
the loop terminates.

[***Next Note***](./07-troubleshooting.md)
