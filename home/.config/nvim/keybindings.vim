" next/prev buffers
nmap <S-Up> :bn<cr>
nmap <S-Down> :bp<cr>
"disable map entering Ex mode
map Q :x<CR>
" write current buffer
nmap <C-w> :w<CR>
" write all buffers, warn if failed
nmap <leader>w :try\|wa\|catch /\<E141\>/\|echomsg 'Not all files saved!'\|endtry<CR>
" write and exit from current buffer
nmap <C-q> :x<CR>
" write and exit all buffers
nmap <silent> <leader>x :xa<CR>
" do Y to yank till the end of the line
nmap Y y$
" splits
nmap <leader>- :split<CR>
nmap <leader>\| :vsplit<CR>
" reload config
nmap <leader>rr :source ~/.dotfiles/nvim/init.vim<cr>
" remap zl back to zo
nnoremap zl zo
" toggle search highlight
nnoremap <silent> <c-_> :set hlsearch!<cr>
" replace selected
nmap R :%s///g<left><left>
" move lines in visual & insert mode
inoremap <S-Up> <Esc>:m .+1<CR>==gi
inoremap <S-Down> <Esc>:m .-2<CR>==gi
vnoremap <S-Up> :m '>+1<CR>gv=gv
vnoremap <S-Down> :m '<-2<CR>gv=gv
