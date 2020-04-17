Plug 'vim-airline/vim-airline'
" enable extra cool font liguria
let g:airline_powerline_fonts = 1
" enable coc integration
let g:airline#extensions#coc#enabled = 1
" show buffer list at the top of the screen
let g:airline#extensions#tabline#enabled = 1
" split buffers at the top using that symbol
let g:airline#extensions#tabline#left_alt_sep = '|'
" show only name of file, instead of full path or so
let g:airline#extensions#tabline#formatter = 'unique_tail'

Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "light"
let g:gruvbox_sign_column = "bg0"
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '|'
" Plug 'joshdick/onedark.vim'
" let g:airline_theme = 'onedark'

" Plug 'nanotech/jellybeans.vim'

" Plug 'lifepillar/vim-solarized8'

" Plug 'rakr/vim-one'

" Plug 'ayu-theme/ayu-vim'
" let ayucolor="mirage"

" Plug 'sainnhe/gruvbox-material'
" let g:airline_theme = 'gruvbox_material'
" let g:gruvbox_material_cursor_line_contrast = 'higher'
" let g:gruvbox_material_background = 'medium'
" let g:gruvbox_material_enable_italic = 1
" let g:gruvbox_material_current_word = 'grey background'

