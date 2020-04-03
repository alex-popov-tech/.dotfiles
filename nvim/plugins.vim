call plug#begin('~/.config/nvim/plugged')
" fuzzy search
source ~/.config/nvim/plugins/fzf.vim
" paste with indenting respected
Plug 'sickill/vim-pasta'
" allows repeat via dot for some plugins like surround
Plug 'tpope/vim-repeat'
" add\update\remove surround stuff like '"{}"'
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
nmap /  <Plug>(incsearch-forward)
nmap ?  <Plug>(incsearch-backward)
nmap z/ <Plug>(incsearch-fuzzy-/)
nmap z? <Plug>(incsearch-fuzzy-?)
nmap *  <Plug>(incsearch-nohl-*)
nmap #  <Plug>(incsearch-nohl-#)
nmap n  <Plug>(incsearch-nohl-n)
nmap N  <Plug>(incsearch-nohl-N)
" make 'f' a bit more usefull
Plug 'rhysd/clever-f.vim'
let g:clever_f_chars_match_any_signs = '/'
let g:clever_f_smart_case=1
" start screen for nvim
source ~/.config/nvim/plugins/startify.vim
" provides function of replacing from yank
Plug 'svermeulen/vim-subversive'
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
" auto placing paired signs like {} [] '' "" etc
Plug 'jiangmiao/auto-pairs'

Plug 'pechorin/any-jump.vim'
nmap gG :AnyJump<cr>
" framework for code completion/navigation/refactoging
source ~/.config/nvim/plugins/coc.nvim.vim
" working with tags, integrated with coc.nvim
Plug 'liuchengxu/vista.vim'
" show sidebar
nmap <leader>ta :Vista!!<CR>
" search through tags
nmap <C-t> :Vista finder coc<CR>
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
map <leader>j :SplitjoinJoin<cr>
map <leader>s :SplitjoinSplit<cr>
" plugin for vim-tmux interactions
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
" syntax highlight
Plug 'sheerun/vim-polyglot'
" plugin which allows vim to work with common editorconfig
Plug 'editorconfig/editorconfig-vim'
" bottom/upper status bar
source ~/.config/nvim/plugins/airline.vim
" some cool themes
source ~/.config/nvim/plugins/colorscheme.vim

call plug#end()

syntax on
set termguicolors
set background=dark
colorscheme gruvbox

