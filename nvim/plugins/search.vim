Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
nmap <leader>/f :GFiles<CR>
nmap <leader>/F :Files<CR>
" find a text in files
nmap <leader>/c :GGrep<CR>
nmap <leader>/C :Ag<CR>
" find a buffer
nmap <leader>/b :Buffers<CR>
" find mark
nmap <leader>/m :Marks<CR>
" find in files history
nmap <leader>/h :History<CR>

" improved search
Plug 'ggvgc/vim-fuzzysearch'
let g:fuzzysearch_prompt = '-> '
let g:fuzzysearch_hlsearch = 1
let g:fuzzysearch_ignorecase = 1
let g:fuzzysearch_max_history = 30
let g:fuzzysearch_match_spaces = 0
nmap / :FuzzySearch<CR>
" replace selected
vmap R :%s///g<left><left>
" make 'f' a bit more usefull
Plug 'rhysd/clever-f.vim'
let g:clever_f_chars_match_any_signs = '/'
let g:clever_f_smart_case=1
