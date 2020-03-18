Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-word',
      \ 'coc-tsserver',
      \ 'coc-json',
      \ 'coc-eslint',
      \ 'coc-tslint',
      \ 'coc-yank',
      \ 'coc-spell-checker',
      \ 'coc-cspell-dicts',
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-sh'
      \]
" if hidden is not set, TextEdit might fail.
" when closes buffer, it hides instead of being abandoned
set hidden
" Some server have issues with backup files, see #649
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
" Better display for messages
" give more space to outputs of executed commands to 2 lines
set cmdheight=1
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=200
" don't give |ins-completion-menu| messages.
" make vim errors shorter
set shortmess+=c
" trigger autocompletion
inoremap <silent><expr> <c-z> coc#refresh()
" navigate between suggestions with tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" confirm by <enter>
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" show list of yanks with preview
nmap <leader>y :CocList --auto-preview --normal yank<CR>
" Navigate interpreter/compiler/linter errors
nmap <leader>e :CocList --number-select --normal --auto-preview diagnostics<CR>
" Remap keys for gotos
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
" navigate througs diagnostic in current buffer
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" rename current word
nmap <leader>rn <Plug>(coc-rename)
" refactor current word
nmap <leader>rf <Plug>(coc-refactor)
" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" format and optimize imports
nmap <leader>F :call Format()<CR>
function! Format()
  :call CocAction('format')
  :call CocAction('runCommand', 'editor.action.organizeImport')
endfunction
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" toggle explorer
nmap <C-f> :CocCommand explorer --preset default<CR>
let g:coc_explorer_global_presets = {
      \   'default': {
      \     'file.child.template': '[git | 2] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1][filename omitCenter 1][readonly] [linkIcon & 1][link growRight 1 omitCenter 5][size]'
      \   }
      \ }
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
" Remap for do codeAction of selected region
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
" remap for do codeaction for <leader>f<motion>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" alias for previos - current line
nmap <silent> <leader>aa :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>0g@$
" fix current line
nmap <silent> <leader>ff <Plug>(coc-fix-current)
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gd <Plug>(coc-git-chunkinfo)

