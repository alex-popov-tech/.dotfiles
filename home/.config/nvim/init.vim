scriptencoding utf-8

filetype plugin indent on

" make two leaders
let mapleader = " "
nmap <BS> <leader>
nmap <Space> <leader>

lua require'settings'
source ~/.config/nvim/keybindings.vim
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/ui.vim
lua require'lsp'
lua require'treesitter'
