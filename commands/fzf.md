# `fzf` fuzzy finder

These are notes on [this video](https://www.youtube.com/watch?v=F8dgIPYjvH8),
documentation, and the Internet.

[***Table of Contents***](/README.md)

By default, it shows you all of the files in your current working directory. To
navigate:

- Up
  - Up arrow
  - Ctrl+n
  - **Ctrl+k**
- Down
  - Down arrow
  - Ctrl+p
  - **Ctrl+j**

Press Enter. The selected entry was output to STDOUT. 

To select multiple files with Tab/Shift+Tab:

```bash
fzf -m
```

To enable fzf keybinding and auto-completion, source the following files:

```bash
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
```

To make these changes permanent, add these same commands to your `zsh` config:

```bash
echo "source /usr/share/fzf/key-bindings.zsh" ~/.zshrc
echo "source /usr/share/fzf/completion.zsh" ~/.zshrc
```

Now you can do better reverse searching with `fzf` (Ctrl+r). Navigate the same
way you would navigate a regular fuzzy search. To exit, hit Esc.

You can search through files with Ctrl+t, the result will be printed to the
command line.

You can output multiple files to the command line with `**` and Tab:

```bash
nvim ** # Press Tab and select files
```

You can pipe commands into `fzf`:

```bash
find . type f | fzf
```

You can preview files with `fzf` as well:

```bash
find . -type f | fzf {}'
```

By default, `bat` highlighting won't work. You need to add options:

```bash
find . -type f | fzf --preview 'bat --style numbers,changes --color=always {}'
```

But yet again there's a problem, you can't navigate the preview! Set up
bindings to navigate up and down in the preview with Alt-j and Alt-k:

```bash
find . -type f | fzf --preview 'bat --style numbers,changes \ 
--color=always {}' --bind \
'ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up'
```

You should probably create an alias for this command, it's quite useful, I
chose `fzp` (fuzzy preview):

```bash
alias fzp="find . -type f | fzf --preview 'bat --style numbers,changes \
--color=always {}' --bind \
'ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up'
```

You can add line wrap, but the preview gets ugly, so I don't use it:
`--preview-window=wrap`.

Or just add the preview navigation to your shell config file:

```bash
export FZF_DEFAULT_OPTS="--bind \
'ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up'"
```

There is a lot more to learn about `fzf`. You can do fascinating things with
`fzf`, try this out:

```bash
curl -s https://api.weather.gov/gridpoints/LWX/96,70/forecast/hourly |  jq -c \
'.properties.periods[]' | fzf --reverse --header 'Make a selection' \
--no-height --preview 'printf %s {} | jq' -e
```
