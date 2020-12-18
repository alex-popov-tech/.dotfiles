"disabl" next/prev buffers
nmap <S-Up> :bn<cr>
nmap <S-Down> :bp<cr>
map Q :x<CR>
" write current buffer
nmap <C-w> :w<CR>
" write and exit from current buffer
nmap <C-q> :x<CR>
" do Y to yank till the end of the line
nmap Y y$
" splits
nmap <leader>- :split<CR>
nmap <leader>\| :vsplit<CR>
" reload config
nmap <leader>rr :source ~/.config/nvim/init.vim<cr>
" remap zl back to zo
nnoremap zl zo
" toggle search highlight
nnoremap <silent> <c-_> :set hlsearch!<cr>
" replace selected
nmap R :%s///g<left><left>
