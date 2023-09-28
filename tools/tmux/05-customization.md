# Customization

[**Contents**](01-intro.md)

Tmux only opens its config file when it's first opened. Even new sessions will
continue to use the old config file until `tmux` is reloaded.

Create the config file:

    vim ~/.tmux.conf

Most likely you have an empty file. When `tmux` launches and there are on
opened sessions, it's going to read this file if it exists and load it into
memory. As long as you don't have any syntax errors, `tmux` will load the file.

Let's change the default prefix key.

    # use C-j and C-f for the prefix.
    set-option -g prefix C-j
    set-option -g prefix2 C-f

You're settings two options within `tmux`, they are global (`-g`), you
customize two prefixes, `C` means "Control" or "Ctrl". There are two prefix
keys, both function the same way. Save the file and test this out: create a
horizontal split (`"`).

Let's create a mapping for config reload:

    # Easy config reload
    bind-key r source-file ~/.tmux.conf \; display-message "tmux.conf reloaded"

`prefix + r` will reload the config file without exiting `tmux`. To test, make
sure you have no `tmux` sessions opened and open up tmux. Try the shortcut, you
will see a message at the bottom.

Open the config file from inside `tmux`. Add a mouse mode configuration:

    # Mouse Mode
    set -g mouse on 

Reload `tmux`. You can drag the pane-dividing line now to change their size.
You can click on a pane to focus it. You can also do that with the keyboard,
look that up yourself.

Let's paste the rest of customizations, you can see what the do in the
comments:

    # Initial setup
    set -g default-terminal xterm-256color
    set -g status-keys vi

    # use C-j and C-f for the prefix.
    set-option -g prefix C-j
    set-option -g prefix2 C-f
    unbind-key C-j
    bind-key C-j send-prefix
    set -g base-index 1

    # Use Alt-arrow keys without prefix key to switch panes
    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D

    # Set easier window split keys
    bind-key v split-window -h
    bind-key h split-window -v

    # Shift arrow to switch windows
    bind -n S-Left  previous-window
    bind -n S-Right next-window

    # Easily reorder windows with CTRL+SHIFT+Arrow
    bind-key -n C-S-Left swap-window -t -1
    bind-key -n C-S-Right swap-window -t +1

    # Synchronize panes
    bind-key y set-window-option synchronize-panes\; display-message "synchronize mode toggled."

    # Easy config reload
    bind-key r source-file ~/.tmux.conf \; display-message "tmux.conf reloaded."

    # Easy clear history
    bind-key L clear-history

    # Key bindings for copy-paste
    setw -g mode-keys vi
    unbind p
    bind p paste-buffer
    bind-key -T copy-mode-vi 'v' send -X begin-selection
    bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

    # Mouse Mode
    set -g mouse on

    # Lengthen the amount of time status messages are displayed
    set-option -g display-time 3000
    set-option -g display-panes-time 3000


    # Set the base-index to 1 rather than 0
    set -g base-index 1
    set-window-option -g pane-base-index 1


    # Automatically set window title
    set-window-option -g automatic-rename on
    set-option -g set-titles on


    # Allow the arrow key to be used immediately after changing windows.
    set-option -g repeat-time 0


    # No delay for escape key press
    set -sg escape-time 0


    # Theme
    set-window-option -g window-status-current-style bold,bg=blue,fg=colour234
    set-window-option -g window-status-style fg=colour35
    set -g window-status-activity-style bold,bg=colour234,fg=white
    set-option -g message-style bg=colour237,fg=colour231
    set-option -g pane-border-style fg=colour36
    set-option -g pane-active-border-style fg=colour35


    # Change background color of a tab when activity occurs
    setw -g monitor-activity on


    # Do NOT reset the color of the tab after activity stops occuring
    setw -g monitor-silence 0


    # Disable bell
    setw -g monitor-bell off


    # Disable visual text box when activity occurs
    set -g visual-activity off


    # Status Bar
    set -g status-justify centre
    set -g status-bg black
    set -g status-fg colour35
    set -g status-interval 60
    set -g status-left-length 50
    set -g status-left "#[bg=colour35]💻#[fg=colour234,bold] #H#[bg=colour34]#[bg=colour35,nobold]#[fg=colour234] [#S] $tmux_target_lower"
    set -g status-right '#[bg=colour35] 🕔 #[fg=colour234,bold]%H:%M '

Close out of everything and launch `tmux` to test stuff out.

- For horizontal split, use `h`; for vertical, use `v`;
- You can now switch between panes with `<ALT+arrows>`;
- `<Shift+left/right arrow>` to switch between windows;
- Reorder windows with `<CTRL+Shift+Left/Right Arrow>`;
- `Prefix + y` to enable sync mode. In sync mode, all windows run the same
  commands. You can connect to multiple servers in different panes and update
  the system on all of them.

There are some theming options there, if you don't like them, remove them.

If you don't want to create a config file, you can enter your commands inside
`tmux`. To activate command mode, do `<Prefix + :>`. You can see a prompt
appear at the bottom. Move your panes around and execute `set -g mouse off`.
Try moving the panes now, you won't be able to since you just disabled mouse
mode. To turn it back on, enter command mode, press the "Up Arrow" key, change
`off` to `on`. Keep your settings in your config file. You can use command mode
to preview changes.
