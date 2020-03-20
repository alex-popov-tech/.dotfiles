Plug 'vim-airline/vim-airline'
" enable extra cool font liguries
let g:airline_powerline_fonts = 1
" enable coc integration
let g:airline#extensions#coc#enabled = 1
" show buffer list at the top of the screen
let g:airline#extensions#tabline#enabled = 1
" split buffers at the top using that symbol
let g:airline#extensions#tabline#left_alt_sep = '|'
" show only name of file, instead of full path or so
let g:airline#extensions#tabline#formatter = 'unique_tail'

