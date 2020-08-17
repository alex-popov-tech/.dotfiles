call plug#begin('~/.config/nvim/plugged')
source ~/.config/nvim/plugins/core.vim
source ~/.config/nvim/plugins/search.vim
source ~/.config/nvim/plugins/ide.vim
source ~/.config/nvim/plugins/ui.vim
source ~/.config/nvim/plugins/tmux.vim
call plug#end()
let g:sandwich#recipes = deepcopy( g:sandwich#default_recipes )
let g:sandwich#recipes = [
  \   {
  \     'buns': ['(', ')'],
  \     'cursor': 'head',
  \     'command': ['startinsert'],
  \     'kind': ['add', 'replace'],
  \     'action': ['add'],
  \     'input': ['f']
  \   },
  \ ]

syntax on
set termguicolors
set background=dark
colorscheme gruvbox
