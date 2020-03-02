# Tmux cheat sheet

## Sessions

* Start new session
  * `tmux`/`tmux new -s <sessionname>`
  * `:new`/`:new -s <sessionname>`
* Kill session
  * `tmux kill-session -t <sessionname>` - kill this session
  * `tmux kill-session -a` - kill all sessions except current
  * `tmux kill-session -a -t <sessionname>` - kill all sessions except `<sessionsname>`
* Rename session
  * `prefix + .`
* Detach from session
  * `prefix + d` - detach from session
* List sessions
  * `tmux ls`
  * `tmux list-sessins`
  * `prefix + s`
* Attach to a session
  * `tmux attach`/`tmux attach -t <sessionname>`
* Navigate through sessions
  * `prefix + )` - next
  * `prefix + (` - previous

## Windows

* Create new window
  * `prefix + c`
* Rename current window
  * `prefix + ,`
* Close current window
  * `prefix : &`
* Next window
  * `prefix + n`
* Previous window
  * `prefix + p`
* Select window by number
  * `prefix + 0..9`
* Reorder window swap window number 2(src) and 1(targ)
  * `swap-window -s 2 -t 1`

## Panes

* Move focus
  * `C-yneo`
* Resize
  * `C-Left/Down/Up/Right`
* Slit
  * Horizontally - `prefix + -`
  * Vertically - `prefix + |`
* Close
  * `prefix + x`
* Show pane numbers
  * `prefix + q`
* Select by index
   `prefix + q + 0..9`
* Move pane (using indexes)
  * Left - `prefix + {`
  * Right - `prefix + }`
* Zoom
  * `prefix-z`
