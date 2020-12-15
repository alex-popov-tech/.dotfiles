Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" fzf commands for lsp sources
Plug 'gfanto/fzf-lsp.nvim'
" previews for fuzzy search
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview('up'), <bang>0)
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('up'), <bang>0)
" search for content occurrences only, not file names
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '', fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up'), <bang>0)
" search for content occurrences in only git files
command! -bang -nargs=* GGrep call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, fzf#vim#with_preview('up'),<bang>0)
" respect color scheme
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
" define actions
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" find in files
nmap <leader>nf :GFiles<CR>
nmap <leader>nF :Files<CR>
" find a text in files
nmap <leader>nc :GGrep<CR>
nmap <leader>nC :Ag<CR>
" find a buffer
nmap <leader>nb :Buffers<CR>
" find mark
nmap <leader>nm :Marks<CR>
" find in files history
nmap <leader>nh :History<CR>
" find/jump definition/reference with fzf
Plug 'pechorin/any-jump.vim'
nmap go :AnyJump<cr>
Plug 'stsewd/fzf-checkout.vim'
let g:fzf_branch_actions = {
      \ 'checkout': {
      \   'execute': 'echo system("{git} checkout " . (empty("{branch}") ? "-b {input}" : "{branch}"))',
      \   'required': [],
      \ },
      \}
cnoreabbrev gb GBranches
