" keymap for keyboardio and workman
nmap { [
nmap } ]
set langmap=hy,yh,nj,jn,ek,ke,lo,ol,HY,YH,NJ,JN,EK,KE,LO,OL
" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with line wrapping on, this can cause the cursor to actually skip a few lines on the screen because it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down' to mean the next line on the screen
nmap j gj
nmap k gk

"disable map entering Ex mode
map Q <Nop>
" write current buffer
nmap <C-w> :w<CR>
" write all buffers, warn if failed
nmap <leader>w :try\|wa\|catch /\<E141\>/\|echomsg 'Not all files saved!'\|endtry<CR>
" write and exit from current buffer
nmap <C-q> :x<CR>
" write and exit all buffers
nmap <silent> <leader>q :xa<CR>
" write and delete current buffer
nmap <silent> <leader>d :bd<CR>
" delete current buffer without saving
nmap <silent> <leader>d :bd!<CR>
" do Y to yank till the end of the line
nmap Y y$
" open embedded terminal
nmap <silent> <leader>te :term<CR>
" Exit from terminal mode to Normal
tnoremap <C-e> <C-\><C-n>
" splits
nmap <leader>- :split<CR>
nmap <leader>\| :vsplit<CR>
" reload config
nmap <leader>R :source ~/.dotfiles/nvim/init.vim<cr>
