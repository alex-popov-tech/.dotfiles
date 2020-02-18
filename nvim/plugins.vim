call plug#begin('~/.config/nvim/plugged')
" fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
" find in files
" https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim
nmap <C-_>f :Files <CR>
nmap <C-_>g :GFiles <CR>
" find a text in files
nmap <C-_>c :Ag <CR>
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
let g:fzf_layout = {'down': '60%'}
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" previews for fuzzy search
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#gitfiles(<q-args>, {'options': ['--layout=reverse', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '', fzf#vim#with_preview(), <bang>0)
" allows repeat via dot for some plugins like surround
Plug 'tpope/vim-repeat'
" start screen for nvim
Plug 'mhinz/vim-startify'
" Automatically save the session when leaving Vim
let g:sessionsdir = '~/.vim/sessions/'
function MakeSession()
  if &ft != 'gitcommit'
    exe "!mkdir -p " . g:sessionsdir
    let b:projectpath = finddir('.git/..', expand('%:p:h').';')
    let b:rawprojectpath = split(b:projectpath, '/')[-1]
    let b:projectname = substitute(b:rawprojectpath, "\\.", "", "")
    let b:filename = g:sessionsdir . b:projectname . '.vim'
    exe "mksession! " . b:filename
  endif
endfunction
autocmd VimLeave * call MakeSession()

let g:startify_session_dir = g:sessionsdir
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ ]
" use vsc root when enter file
let g:startify_change_to_vcs_root = 1
" open startify along with nerdtree
autocmd VimEnter * if !argc() | Startify | endif
" do not show 'edit' and 'quit' options
let g:startify_enable_special = 0
let g:startify_custom_indices = [ 'a', 's', 't', 'g', 'y', 'n', 'e', 'o', 'i', 'q', 'd', 'r', 'w', 'f', 'u', 'p']
" add\update\remove surround stuff like '"{[]}"'
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
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-word',
      \ 'coc-dictionary',
      \ 'coc-tsserver',
      \ 'coc-json',
      \ 'coc-eslint',
      \ 'coc-yank',
      \ 'coc-tabnine',
      \ 'coc-spell-checker',
      \ 'coc-cspell-dicts',
      \ 'coc-marketplace',
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-sh'
      \]
" CocCommand explorer --toggle --file-columns=diagnosticError:git:selection:clip:indent:icon:filename;filename;fullpath;size;modified;readonly;created;modified;accessed
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
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" confirm by <enter>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" show list of yanks with preview
nmap <leader>y :CocList --auto-preview --normal yank<CR>
" Navigate interpreter/compiler/linter errors
nmap <leader>e :CocList --number-select --normal --auto-preview diagnostics<CR>
" Remap keys for gotos
nmap <C-g>d <Plug>(coc-definition)
nmap <C-g>y <Plug>(coc-type-definition)
nmap <C-g>i <Plug>(coc-implementation)
nmap <C-g>r <Plug>(coc-references)
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
nmap <C-f> :CocCommand explorer --toggle --file-columns=diagnosticError:git:selection:clip:indent:icon:filename;filename;fullpath;size;modified;readonly;created;modified;accessed<CR>
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
" Remap for do codeAction of selected region
xmap <silent> <leader>f :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
" remap for do codeaction for <leader>f<motion>
nmap <silent> <leader>f :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" alias for previos - current line
nmap <silent> <leader>ff :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>0g@$
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
Plug 'christoomey/vim-tmux-navigator'
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2
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
" special status line for nerd tree buffer
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
