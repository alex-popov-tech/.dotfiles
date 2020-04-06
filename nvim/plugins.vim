call plug#begin('~/.config/nvim/plugged')
source ~/.config/nvim/plugins/core.vim
source ~/.config/nvim/plugins/search.vim
source ~/.config/nvim/plugins/ide.vim
source ~/.config/nvim/plugins/session.vim
source ~/.config/nvim/plugins/ui.vim
call plug#end()

syntax on
set termguicolors
set background=dark
colorscheme gruvbox
