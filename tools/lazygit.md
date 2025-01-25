# `lazygit`

[***Table of Contents***](/README.md)  

`lazygit` is a terminal UI for `git` commands:

```bash
lazygit
```

`?` to call the help menu. You can search in it with `/` (in most menus in
`lazygit`).

To switch between different sections, press the corresponding number:
- `1` - status
- `2` - files
- `3` - local branches
- `4` - commits
- `5` - stash

On the bottom, there are popular hotkeys and their names, e.g. `Checkout:
<space>` in `[3] Local branches`.

### Staging & Committing

In the second (`[2]`) tab, there are files with their statuses to their left.
To stage a file, press Space. To stage all files, press `a`. Use the same
keybinding to unstage. You can also stage multiple entries by pressing `v`,
selecting needed files and pressing Space.

To commit:
- `c`
- enter the commit message

### Amending the Last Commit

1. do whatever changes you want, e.g., to add more files:
    1. `[2]`
    1. stage whatever files you want with `space` and `a`
1. go to `[4] Commits` 
1. select the commit to amend
1. press `A`
1. confirm

### Rewording a Commit Message

1. go to `[4] Commits`
1. select the commit you would like to reword
1. press `r`
### Useful Links 

- [Documentation](https://github.com/jesseduffield/lazygit/tree/master/docs)
- [Keybindings](https://github.com/jesseduffield/lazygit/blob/master/docs/keybindings/Keybindings_en.md)
