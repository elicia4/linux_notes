# 10. NVChad Setup, Hotkeys, and Configurations

[***go back to README***](README.md)

These are notes on [this video](https://youtu.be/Mtgo-nP_r8Y).

To set up:

1. Install neovim:

   ```
   pacman -S neovim
   ```

1. Change the default aliases to nvim:

   ```
   echo "alias vi=nvim;" >> .zshrc
   echo "alias vim=nvim;" >> .zshrc
   ```

1. Install Nerd Font (JetBrainsMono Nerd Font)
1. Install git
1. Install NVChad, backup and delete cache first:

   ```
   mv ~/.config/nvim ~/.config/nvim.backup # backup
   rm -rf ~/.local/share/nvim
   git clone https://github.com/NVChad/NVChad ~/.config/vim --depth 1
   ```

1. Open up `vim`.
1. Do not install the example config.

### Hotkeys

1. To change theme: ' ' + `t` + `h` (`ctrl+p`/`ctrl+n` to navigate)
1. To install syntax highlighting:
    
```
:TSInstall elixir
```

   To check which ones you have installed:

```
:TSInstallInfo
```

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

1. Let's add syntax highlighting for crystal:

```
vim ~/.config/nvim/lua/custom/chadrc.lua
```

   It's recommended to group all plugins in their own config file called
   `plugins.lua`:
    
```lua
...
M.plugins = 'custom.plugins'
return M
```

   Add the following text inside:

```lua
local plugins = {
  {
      "vim-crystal/vim-crystal"
      ft = "crystal"
      lazy = false
  }
}
return plugins
```

   We also specified the file type we want the plugin to load for, that's
   because NVChad uses the lazy plugin manager. You can also disable lazy
   loading for a plugin by setting the `lazy` key to `false`. To install a
   plugin: `:Lazy sync`. After that, reopen `vim`.

   You can add any plugin configurations to `plugins.lua`. You can add
   autoformatting of crystal code to your plugin:

```lua
...
ft = "crystal",
config = function(_)
  vim.g.crystal_auto_format = 1
end
```

    You can set standard vim configurations in `init.lua`:

```lua
vim.opt.colorcolumn = "80"
```

### LSP

LSP means "language server protocol". It enables editors to receive code
completion and other tooling using language servers. Neovim comes with this out
of the box. 

Let's add an LSP config for Rust analyzer. We have to add an override for our
LSP config package configuration:

```
vim ~/.config/nvim/lua/custom/plugins.lua
```

Add a new entry for `neovim/nvim-lspconfig`:

```lua
...
  end
},
{
    "neovim/nvim-lspconfig",
    config = function()
      require = "plugins.configs.lspconfig"
      require = "custom.configs.lspconfig"
    end,
}
```

Create the files:

```
mkdir ~/.config/nvim/lua/custom/configs/
touch ~/.config/nvim/lua/custom/configs/lspconfig.lua
```

Add the following lines to it:

```lua
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = lspconfig.util.root_pattern("Cargo.toml"),
})
```

If you want to add in other LSP server configurations, you can reference the
neovim LSP config server configurations guide on GitHub. Or you can use: `:help
lspconfig-all`.

Make sure you have Rust analyzer installed on your system:

```
rustup component add rust-analyzer
```

Or you can use the Mason plugin provided by NVChad to manage LSP binaries for
you. 

To use mason is as simple as adding an entry to our custom config to override
the default config:

```lua
...
  end,
},
{
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "rust-analyzer",
    }
  }
}
...
```

Then use the command `:MasonInstallAll` to download and install the language
server.
