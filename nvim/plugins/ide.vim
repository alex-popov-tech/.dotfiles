" =====================================================================
" ============================= COC.NVIM ==============================
" =====================================================================
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
            \ 'coc-actions',
            \ 'coc-vimlsp',
            \ 'coc-tsserver',
            \ 'coc-tabnine',
            \ 'coc-spell-checker',
            \ 'coc-cspell-dicts',
            \ 'coc-snippets',
            \ 'coc-json',
            \ 'coc-yaml',
            \ 'coc-eslint',
            \ 'coc-yank',
            \ 'coc-tslint',
            \ 'coc-explorer',
            \ 'coc-git',
            \ 'coc-java',
            \ 'coc-post',
            \ 'coc-marketplace'
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
set updatetime=50
autocmd CursorHold * call CocActionAsync('highlight')
hi! link CocHighlightText GruvboxAqua
" don't give |ins-completion-menu| messages.
" make vim errors shorter
set shortmess+=c
" navigate between suggestions with tab, trigger auto-completion with tap
inoremap <silent><expr> <Down>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Down>" :
            \ coc#refresh()
inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" confirm by <enter>
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <Right> coc#refresh()
" show list of yanks with preview
nmap <leader>y :CocFzfList yank<CR>
" Navigate interpreter/compiler/linter errors
nmap <leader>dd :CocFzfList diagnostics --current-buf<CR>
" Remap keys for gotos
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
" navigate througs diagnostic in current buffer
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>pr :CocSearch <C-R>=expand("<cword>")<cr><cr>
" refactor current word
nmap <leader>rf <Plug>(coc-refactor)
" format and optimize imports
nmap <leader>F :call Format()<CR>
function! Format()
    :call CocAction('format')
    let filetypesWithImports = ['javascript', 'typescript']
    if index(filetypesWithImports, &filetype) != -1
        :call CocAction('runCommand', 'editor.action.organizeImport')
    endif
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
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
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
" checkout current chunk
nmap gu <Plug>(coc-git-undochunk)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_next = '<Right>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'
let g:coc_snippet_prev = '<Left>'
" trigger snipped expand from completion window directly
imap <Right> <Plug>(coc-snippets-expand-jump)
Plug 'antoinemadec/coc-fzf'
" =====================================================================
" =============================== VISTA ===============================
" =====================================================================
" working with tags, integrated with coc.nvim
Plug 'liuchengxu/vista.vim'
" show sidebar
nmap <C-t> :Vista!!<CR>
" search through tags
nmap ?t :Vista finder coc<CR>
" by default use coc.nvim to get tags
let g:vista_default_executive = 'coc'
" show floating window with tag preview on hover
let g:vista_echo_cursor_strategy = 'floating_win'
" alter icons in sidebar
let g:vista_icon_indent = [ "", "├─▸"]
" preview in search
let g:vista_fzf_preview = ['right:50%']
" =====================================================================
" =============================== OTHER ===============================
" =====================================================================
" add commenting for different langs via gcc
Plug 'tpope/vim-commentary'
" comment mappings
nmap <leader>c gcc
vmap <leader>c gc
" add switch toggles
Plug 'AndrewRadev/switch.vim'
let g:switch_mapping='-'
" syntax highlight
Plug 'sheerun/vim-polyglot'
" don't conceal links like SOME_LINK instead of [SOME_LINK](some link url)
let g:vim_markdown_conceal = 0
set conceallevel=1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_this                 = "@"
" plugin which allows vim to work with common editorconfig
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'
