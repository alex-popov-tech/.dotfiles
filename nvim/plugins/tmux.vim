" plugin for vim-tmux interactions
Plug 'christoomey/vim-tmux-navigator'
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2
let g:tmux_navigator_no_mappings = 1
map <C-y> :TmuxNavigateLeft<cr>
map <C-n> :TmuxNavigateDown<cr>
map <C-e> :TmuxNavigateUp<cr>
map <C-o> :TmuxNavigateRight<cr>
" resizing windows
Plug 'talek/obvious-resize'
let g:obvious_resize_default = 4
let g:obvious_resize_run_tmux = 1
map <silent> <C-Up> :ObviousResizeUp<CR>
map <silent> <C-Down> :ObviousResizeDown<CR>
map <silent> <C-Left> :ObviousResizeLeft<CR>
map <silent> <C-Right> :ObviousResizeRight<CR>
" send lines to tmux pane repl
Plug 'esamattis/slimux'
