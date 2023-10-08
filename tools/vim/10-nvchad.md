# 10. NVChad Hotkeys

[***go back to README***](README.md)

To set up:

1. Install neovim:

    pacman -S neovim

1. Change the default aliases to nvim:

    echo "alias vi=nvim;" >> .zshrc
    echo "alias vim=nvim;" >> .zshrc

1. Install Nerd Font (JetBrainsMono Nerd Font)
1. Install git
1. Install NVChad, backup and delete cache first:

    mv ~/.config/nvim ~/.config/nvim.backup # backup
    rm -rf ~/.local/share/nvim
    git clone https://github.com/NVChad/NVChad ~/.config/vim --depth 1

1. Open up `vim`.
1. Do not install the example config.

### Hotkeys

1. To change theme: ' ' + `t` + `h` (`ctrl+p`/`ctrl+n` to navigate)
1. To install syntax highlighting:
    
    TSInstall elixir

   To check which ones you have installed:

    TSInstallInfo

1. To open the file tree: `space + e`
   - You can mark a file by pressing `m`
   - You can create a file with `a`
   - You can copy with `c`, paste with `p`, rename using `r`, delete with `d`

1. To open "find files" menu: `space + f + f`

1. The space key is the leader key

1. To close windows, use `space + x`

1. To perform a search across files you have opened: `space + f + b`

1. To open up a cheatsheet: `space + c + h`

1. If you press `space` and wait for a second, suggestions will appeear.

1. To view git commits: `space + c + m`

1. To move between windows: `CTRL + h/j/k/l`

1. To create a vertical/horizontal split: `:vsp`, `:sp`

1. To toggle relative line numbers: `space + r + n`

1. To toggle line numbers: `space + n`

1. To cycle through buffers, use `TAB` / `Shift+TAB`

1. To open a command line shell: `space + h` / `space + v`

1. To write current buffer: `Ctrl + s`

### Customization

1. You can customize NVChad in `~/.config/nvim/lua/custom` directory, there
   are:

   - `chadrc.lua` is used for overwriting the default config lua table
     (plugins/nvchad options)
   - `init.lua` is used for overwriting neovim options and commands (neovim/vim
     configurations)
