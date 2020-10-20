call plug#begin('~/.config/nvim/plugged')
source ~/.config/nvim/plugins/core.vim
source ~/.config/nvim/plugins/search.vim
source ~/.config/nvim/plugins/ide.vim
source ~/.config/nvim/plugins/ui.vim
source ~/.config/nvim/plugins/tmux.vim
call plug#end()

syntax on
set termguicolors
set background=dark

colorscheme gruvbox

hi DiffAdd   cterm=none ctermfg=none ctermbg=none gui=none guifg=#5fd700 guibg=none
hi DiffText   cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none
hi DiffChange   cterm=none ctermfg=none ctermbg=none gui=none guifg=#ffff00 guibg=none
hi DiffDelete cterm=none ctermfg=none ctermbg=none gui=none guifg=#ff0000 guibg=none
