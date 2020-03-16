call plug#begin('~/.config/nvim/plugged')
" fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
" find in files
nmap <C-_>f :Files<CR>
nmap <C-_>F :GFiles<CR>
" find a text in files
nmap <C-_>c :Ag<CR>
nmap <C-_>b :Buffers<CR>
nmap <C-_>m :Marks<CR>
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
let g:fzf_layout = {'down': '80%'}
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" previews for fuzzy search
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview('up'), <bang>0)
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('up'), <bang>0)
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '', fzf#vim#with_preview('up'), <bang>0)
" allows repeat via dot for some plugins like surround
Plug 'tpope/vim-repeat'
" start screen for nvim
Plug 'mhinz/vim-startify'
" Automatically save the session when leaving Vim
let g:sessionsdir = '~/.vim/sessions/'
let g:startify_session_dir = g:sessionsdir
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ ]
" use vsc root when enter file
let g:startify_change_to_vcs_root = 1
" do not show 'edit' and 'quit' options
let g:startify_enable_special = 0

function EnsureSessionsDirExists()
  exe "!mkdir -p ". g:sessionsdir
endfunction

" is current dir a git repo
function IsGitRepository()
  if !empty(glob('.git'))
    return 1
  else
    return 0
  endif
endfunction

" ~/.dotfiles -> .dotfiles
" ~/Documents/selenidejs-webdriver-jasmine-example -> selenidejs-webdriver-jasmine-example
function GetProjectNameFromPath()
  let b:projectpath = finddir('.git/..', expand('%:p:h').';')
  let b:rawprojectpath = split(b:projectpath, '/')[-1]
  let b:projectname = substitute(b:rawprojectpath, "\\.", "", "")
  return b:projectname
endfunction

" dotfiles -> ~/.vim/sessions/dotfiles.vim
function GetSessionNameForProject(projectname)
  return g:sessionsdir . a:projectname . '.vim'
endfunction

" write session file
function EnsureSession()
  if &ft != 'gitcommit' || empty(&ft)
    call s:closeOldBuffers()
    call EnsureSessionsDirExists()
    let b:projectname = GetProjectNameFromPath()
    let b:filename = GetSessionNameForProject(b:projectname)
    exe "mksession! " . b:filename
  endif
endfunction

" is file empty
function! IsFileEmpty(filepath)
  let lines = readfile(a:filepath)    " read the file *contents* into a list
  let matched_index = match(lines, '\S')  " find the first entry with a non-space
  return matched_index == -1              " if no match was found -1 was returned
endfunction

" open session if exists, startify otherwise
function OpenSessionOrStartify()
  if !argc()
    if IsGitRepository()
      let b:projectname = GetProjectNameFromPath()
      let b:projectsessionname = GetSessionNameForProject(b:projectname)
      if !empty(glob(b:projectsessionname)) && !IsFileEmpty(glob(b:projectsessionname))
        execute "source" b:projectsessionname
      endif
    else
      Startify
    endif
  endif
endfunction

" help functions from fzf.vim
function! s:buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction
function! s:sort_buffers(...)
  let [b1, b2] = map(copy(a:000), 'get(g:fzf#vim#buffers, v:val, v:val)')
  " Using minus between a float and a number in a sort function causes an error
  return b1 < b2 ? 1 : -1
endfunction
function! s:buflisted_sorted()
  return sort(s:buflisted(), 's:sort_buffers')
endfunction

" Close all active buffers except last N
let s:buffers_to_keep = 10
function! s:closeOldBuffers()
  let buffers = s:buflisted_sorted()
  if len(buffers) < s:buffers_to_keep
    return
  endif
  let buffers_to_close = buffers[s:buffers_to_keep:]
  for buffer in buffers_to_close
    echo buffer
    silent exe 'bdel ' . buffer
  endfor
endfunction

" save session on exit, open session/startify on enter
autocmd VimLeave * call EnsureSession()
autocmd VimEnter * nested call OpenSessionOrStartify()
" add\update\remove surround stuff like '"{}"'
Plug 'tpope/vim-surround'
" add text objects like in ,, .. {} () etc.
Plug 'wellle/targets.vim'
" add text objects depends on indenting <count>ai|ii|aI|iI
Plug 'michaeljsmith/vim-indent-object'
" line text objects
xnoremap il g_o0
onoremap il :normal vil<CR>
xnoremap al $o0
onoremap al :normal val<CR>
" add commenting for different langs via gcc
Plug 'tpope/vim-commentary'
" comment mappings
nmap <leader>c gcc
vmap <leader>c gc
" add switch toggles
Plug 'AndrewRadev/switch.vim'
let g:switch_mapping='-'
" add bunch of mapping
Plug 'tpope/vim-unimpaired'
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
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
" auto placing paired signs like {} [] '' "" etc
Plug 'jiangmiao/auto-pairs'
" framework for code completion/navigation/refactoging
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-word',
      \ 'coc-dictionary',
      \ 'coc-tsserver',
      \ 'coc-json',
      \ 'coc-eslint',
      \ 'coc-tslint',
      \ 'coc-yank',
      \ 'coc-tabnine',
      \ 'coc-spell-checker',
      \ 'coc-cspell-dicts',
      \ 'coc-marketplace',
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
set updatetime=750
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
" nmap <C-g>d <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
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
" toggle join/split for args, dicts, ecs.
Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>
Plug 'christoomey/vim-tmux-navigator'
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2
let g:tmux_navigator_no_mappings = 1
map <C-y> :TmuxNavigateLeft<cr>
map <C-n> :TmuxNavigateDown<cr>
map <C-e> :TmuxNavigateUp<cr>
map <C-o> :TmuxNavigateRight<cr>
" resizing windows
Plug 'talek/obvious-resize'
let g:obvious_resize_default = 4
let g:obvious_resize_run_tmux = 1
map <silent> <C-Up> :ObviousResizeUp<CR>
map <silent> <C-Down> :ObviousResizeDown<CR>
map <silent> <C-Left> :ObviousResizeLeft<CR>
map <silent> <C-Right> :ObviousResizeRight<CR>
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

" some cool themes
Plug 'joshdick/onedark.vim'
" let g:airline_theme = 'onedark'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_sign_column = "bg0"
" let g:gruvbox_color_column = 'bg0'
" Plug 'nanotech/jellybeans.vim'
" Plug 'lifepillar/vim-solarized8'
" Plug 'rakr/vim-one'
" Plug 'ayu-theme/ayu-vim'
" let ayucolor="mirage"

call plug#end()

syntax on
" set TRUE COLOR to beautify
set termguicolors
set background=dark
colorscheme gruvbox

