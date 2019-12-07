call plug#begin('~/.config/nvim/plugged')
" fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
" find in all files
nmap <leader>/F :Files <CR>
" find in git files
nmap <leader>/gf :GFiles <CR>
" find in commits
nmap <leader>/gc :Commits <CR>
" find a text in files
nmap <leader>/fc :Ag <CR>
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
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" previews for fuzzy search
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
command! -bang -nargs=? Ag
    \ call fzf#vim#grep(printf('ack --nocolor %s || true', shellescape(<q-args>)), 1, {'options': ['--layout=reverse', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

" file tree buffer
Plug 'scrooloose/nerdtree'
" toggle screen file tree on double leader and refresh root node immediately
nmap <leader>fc :NERDTreeFind <bar> :NERDTreeRefreshRoot <CR>
" toggle screen file tree on double leader and refresh root node immediately
nmap <leader>ft :NERDTreeToggle <bar> :NERDTreeRefreshRoot <CR>
" disable help menu at the top
let NERDTreeMinimalUI = 1
" delete buffer on delete file from tree
let NERDTreeAutoDeleteBuffer = 1
" close tree on file open
let NERDTreeQuitOnOpen = 1
" open nerd tree by default when calling nvim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" configure sidebar size
let NERDTreeWinSize = 30
" add icons for tree folders
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
" show git status of files in nerd tree
Plug 'Xuyuanp/nerdtree-git-plugin'
" icons for git marks in tree
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "●",
      \ "Staged"    : "✔",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "❗",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "~",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : '☒',
      \ "Unknown"   : "❓"
      \ }
" show added\updated lines to the left of line number
Plug 'airblade/vim-gitgutter'
" git plugin
Plug 'tpope/vim-fugitive'
" git status
nmap <leader>gs :Gstatus <CR>
" git add current file
nmap <leader>gw :Gwrite <CR>
" git checkout current file
nmap <leader>gr :Gread <CR>
" git commit
nmap <leader>gc :Gcommit <CR>
" git log for all files
nmap <leader>gla :Glog -- <CR>
" show differences for current buffer
nmap <leader>gdf :Gdiff <CR>
" git push
nmap <leader>gp :Gpush <CR>
" allows repeat via dot for some plugins like surround
Plug 'tpope/vim-repeat'
" add\update\remove surround stuff like '"{[]}"'
Plug 'tpope/vim-surround'
" add text objects like in ,, .. {} () etc.
Plug 'wellle/targets.vim'
" add text objects depends on indenting <count>ai|ii|aI|iI
Plug 'michaeljsmith/vim-indent-object'
" add commenting for different langs via gcc
Plug 'tpope/vim-commentary'
" comment mappings
nmap <leader>c gcc
vmap <leader>c gc
" add bunch of mapping
Plug 'tpope/vim-unimpaired'
" add ability to select multiple places at the same time
Plug 'terryma/vim-multiple-cursors'
" improved search
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
" auto remove search hightlight by moving
let g:incsearch#auto_nohlsearch = 1
" mapping for plain and fuzzy search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
" clear hightlight
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
" make 'f' a bit more usefull
Plug 'rhysd/clever-f.vim'
let g:clever_f_chars_match_any_signs = '.'
let g:clever_f_smart_case=1
" provides function of replacing from yank
Plug 'svermeulen/vim-subversive'
nmap <leader>p <plug>(SubversiveSubstitute)
nmap <leader>pp <plug>(SubversiveSubstituteLine)
nmap <leader>P <plug>(SubversiveSubstituteToEndOfLine)
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
let g:coc_global_extensions = [
      \ 'coc-word',
      \ 'coc-tsserver',
      \ 'coc-tslint-plugin',
      \ 'coc-json',
      \ 'coc-eslint',
      \ 'coc-python',
      \ 'coc-pairs',
      \ 'coc-java',
      \ 'coc-solargraph',
      \ 'coc-yaml',
      \ 'coc-yank',
      \ 'coc-tabnine',
      \ 'coc-diagnostic',
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
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
" make vim errors shorter
set shortmess+=c
" always show signcolumns
" always show column to the left of lines number column, f.e. for git glutter
set signcolumn=yes
" show list of yanks with preview
nnoremap <silent> <leader>y :<C-u>CocList -A --normal yank<CR>
" Navigate interpreter/compiler/linter errors
nmap <silent> [r <Plug>(coc-diagnostic-prev)
nmap <silent> ]r <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" format indent on selected lines
nmap <leader>fi  <Plug>(coc-format-selected)
vmap <leader>fi  <Plug>(coc-format-selected)
" Fix autofix problem of current line
nmap <leader>fl  <Plug>(coc-fix-current)
augroup cocnvim
  autocmd!
  " fix indenting on save buffer
  autocmd BufWritePre * :call CocAction('format')
  " organize import on save buffer
  autocmd BufWritePre *.ts,*.js :call CocAction('runCommand', 'editor.action.organizeImport') | sleep 100m
augroup end
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" working with tags, integrated with coc.nvim
Plug 'liuchengxu/vista.vim'
" show sidebar
nmap <leader>ta :Vista!!<CR>
" search through tags
nmap <leader>/ta :Vista finder coc<CR>
" by default use coc.nvim to get tags
let g:vista_default_executive = 'coc'
" show floating window with tag preview on hover
let g:vista_echo_cursor_strategy = 'floating_win'
" alter icons in sidebar
let g:vista_icon_indent = [ "", "├─▸"]
" preview in search
let g:vista_fzf_preview = ['right:50%']
" lint whitespaces
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
" plugin which allows vim to work with common editorconfig
Plug 'editorconfig/editorconfig-vim'
" syntax highlight
Plug 'ekalinin/Dockerfile.vim'
" syntax hightlight
Plug 'elzr/vim-json'
" conceal double-quotes when not hover a line with them
let g:vim_json_syntax_conceal = 1
" syntax hightlight for yaml
Plug 'stephpy/vim-yaml'
" preview markdown in browser
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" visual hightlight for markdown files
Plug 'plasticboy/vim-markdown'
" disable all possible folding
let g:vim_markdown_folding_disabled = 1

" bottom/upper status bar
Plug 'vim-airline/vim-airline'
" show buffer list at the top of the screen
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" split buffers at the top using that symbol
let g:airline#extensions#tabline#left_alt_sep = '|'
" show only name of file, instead of full path or so
let g:airline#extensions#tabline#formatter = 'unique_tail'
" remove trailing whitespace in status line
let g:airline#extensions#whitespace#enabled = 0
" enable extra cool font liguries
let g:airline_powerline_fonts = 1
" special status line for nerd tree buffer
let g:airline_filetype_overrides = {
      \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
      \ }
Plug 'vim-airline/vim-airline-themes'

" some cool themes
" Plug 'joshdick/onedark.vim'
" let g:airline_theme = 'onedark'
" Plug 'morhetz/gruvbox'
" let g:gruvbox_sign_column="bg0"
" let g:gruvbox_invert_selection=0
" let g:gruvbox_contrast_dark = 'dark'
" let g:airline_theme = 'base16'
" Plug 'nanotech/jellybeans.vim'
" Plug 'lifepillar/vim-solarized8'
Plug 'rakr/vim-one'
let g:airline_theme = 'one'
let g:one_allow_italics = 1

call plug#end()
