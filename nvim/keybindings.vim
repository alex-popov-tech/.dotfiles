" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with line wrapping on, this can cause the cursor to actually skip a few lines on the screen because it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down' to mean the next line on the screen
nmap j gj
nmap k gk

" keymap for keyboardio
nmap { [
nmap } ]

" goto line using 1234<Enter>
nnoremap <CR> G

"disable map entering Ex mode
map Q <Nop>
" write current buffer
nmap <C-w> :w<CR>
" write all buffers
nmap <leader>w :wa<CR>
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

" for choosing in popup menu via <C-j> and <C-k>
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" alias for git diffs
nmap <leader>gdg :diffget<CR>
nmap <leader>gdp :diffput<CR>
xmap <leader>gdg :diffget<CR>
xmap <leader>gdp :diffput<CR>

nmap <leader>s :split<CR>
nmap <leader>v :vsplit<CR>
