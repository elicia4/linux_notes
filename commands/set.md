# `set`

[***Table of Contents***](/README.md)

This is a note on [this video by
Jake@Linux.](https://www.youtube.com/watch?v=YWZ_5ezM8ko)

---

You can use it to set options that change the behavior of scripts.

`set -f` disables filename expansion (globbing):

```bash
#!/bin/bash

# disable filename expansion (globbing)
set -f

ls *.txt

set +f # enables it back
```

This way, if you have filenames with special characters, they will be
interacted with normally, shell expansions won't be applied on them.

`set -e` enables exit on error. Please note that these can be applied on
sections of your script, there's no need to use these for the entirety of
your scripts (though obviously still possible). E.g.:

```bash
#!/bin/bash
# enable exit on error for critical section
set -e

# obviously a critically important command. If it fails, the script shall exit
cp important_file.txt /backup/location

set +e

# these two won't run if `cp` fails
echo "Backup operation completed, continuing with the script..."
echo "Performing other non-critical operations..."
```

`set -eu` will enable strict error handling and treat unset variables as an
error:

```bash
#!/bin/bash
# Enable strict error handling and treat unset variables as an error
set -eu

process_file() {
  local filename="$1"
  
  if [[ ! -f "${filename}" ]]; then
    echo "Error: File '${filename}' not found."
    return 1
  fi

  local line_count
  line_count=$(wc -l < "${filename}")
  echo "File '$filename' has ${line_count} lines."
}

process_file "${1:-}"

echo "Script completed successfully."
```

With this `set -eu`, the script will terminate if the provided file doesn't
exist (because the `filename` variable won't be set). The last `echo`
won't be executed as well. It the file exists, the `echo` will be executed.

It `set -eu` wasn't set, the last `echo` would execute even if the variable
wasn't set.
