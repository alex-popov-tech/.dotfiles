" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with line wrapping on, this can cause the cursor to actually skip a few lines on the screen because it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down' to mean the next line on the screen
nmap j gj
nmap k gk

"disable map entering Ex mode
map Q <Nop>
" write current buffer
nmap <leader>w :w<CR>
" write all buffers
nmap <leader>W :wa<CR>
" write and exit from current buffer
nmap <silent> <leader>q :x<CR>
" write and exit all buffers
nmap <silent> <leader>Q :xa<CR>
" write and delete current buffer
nmap <silent> <leader>d :bd<CR>
" delete current buffer without saving
nmap <silent> <leader>D :bd!<CR>
" open embedded terminal
nmap <silent> <leader>te :term<CR>

" for choosing in popup menu via <C-j> and <C-k>
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" alias for git diffs
nmap <leader>gdg :diffget<CR>
nmap <leader>gdp :diffput<CR>
xmap <leader>gdg :diffget<CR>
xmap <leader>gdp :diffput<CR>

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
" Open new split for C+hjkl, if split doesnt exist
map <silent> <Left> :call WinMove('h')<CR>
map <silent> <Down> :call WinMove('j')<CR>
map <silent> <Up> :call WinMove('k')<CR>
map <silent> <Right> :call WinMove('l')<CR>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

" resize windows with <C-UIOP>
nnoremap <C-i> <C-W>+
nnoremap <C-u> <C-W>-
nnoremap <C-y> <C-W>>
nnoremap <C-o> <C-W><

" Exit from terminal mode to Normal
tnoremap <C-e> <C-\><C-n>
