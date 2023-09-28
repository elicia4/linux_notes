# Splits and Panes

You can carve up your windows into sections. You can split your screen
vertically and horizontally.

Those vertical/horizontal splits are called panes. 

Start up `tmux`:

    tmux

To interact with `tmux`, use the prefix key `<CTRL-B>`. To create a vertical
pane, press `%`. These hotkeys are terrible, you can learn how to customize
them in the last note. For now, stick to the default ones.

To split horizontally, use `"`. The split is created in whatever quadrant you
are. 

To switch between panes use the arrow keys (use the prefix key before every
instruction as usual).

Let's try a hands-on example. Close all of the panes, run `exit` in each one of
them (or press `<CTRL-D>`):

    exit

See if you have a session:

    tmux list-sessions

1. Run `tmux`
1. Create a vertical split
1. Move to the left pane
1. Create a horizontal pane
1. You should now have a reverse of the layout you had before.
1. In the top left pane, run `htop`
1. Run `journalctl -f` in the bottom left pane
1. The left side of the screen gives you system information, you can work in
   the right side of the screen
1. Run `sudo apt update` (or whatever else) in the right pane.
1. Detach from the session
1. List `tmux` sessions
1. Go back to the session

`exit` isn't `tmux`-specific, you can exit from most Linux sessions by running
`exit`. You don't have to `exit`, you can send the prefix and issue the `x`
instruction, confirm with `y`.
