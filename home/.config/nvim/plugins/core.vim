" debug vim runtime
Plug 'dstein64/vim-startuptime'
" scroll bar
Plug 'dstein64/nvim-scrollview'
" main text objects plugin
Plug 'kana/vim-textobj-user'
" dac dic yic cic
Plug 'glts/vim-textobj-comment'
" dii cai
Plug 'kana/vim-textobj-indent'
" add text objects like in ,, .. {} () dab, daq, daa
Plug 'wellle/targets.vim'
" abbreviations, substitusion, coercion (transform case)
Plug 'tpope/vim-abolish'
" add bunch of mappings like ]p ]e ]<space> etc.
Plug 'tpope/vim-unimpaired'
" allows repeat via dot for some plugins like surround
Plug 'tpope/vim-repeat'
" add\update\remove surround stuff like '"{}"'
Plug 'tpope/vim-surround'
" automatically adjust shiftwidth/expandtab/etc
Plug 'tpope/vim-sleuth'
" git plugin
Plug 'tpope/vim-fugitive'
cnoreabbrev gp Gpush
command Gs :Git | on
cnoreabbrev gs Gs
nmap gm :diffget //2<cr>
nmap gt :diffget //3<cr>
" auto placing paired signs like {} [] '' "" etc
Plug 'cohama/lexima.vim'
" when navigate to previously opened files - open in last file position
Plug 'farmergreg/vim-lastplace'
" start screen
Plug 'mhinz/vim-startify'
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
      \ ]
" use vsc root when enter file
let g:startify_change_to_vcs_root = 1
" do not show 'edit' and 'quit' options
let g:startify_enable_special = 1
" start from 1 when choosing
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
" text object camel case word
Plug 'chaoren/vim-wordmotion'
let g:wordmotion_prefix = '<leader>'
" kill all buffers but current
Plug 'schickling/vim-bufonly'
cnoreabbrev bo Bonly!
" open terminal in floating window
Plug 'voldikss/vim-floaterm'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
noremap  <F11> :FloatermToggle<CR>
tnoremap <F11> <C-\><C-n>:FloatermToggle<CR>
Plug 'svermeulen/vim-subversive'
nmap m <plug>(SubversiveSubstitute)
nmap mm <plug>(SubversiveSubstituteLine)
" file tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
nmap <c-f> :LuaTreeToggle<cr>
let g:lua_tree_side = 'left'
let g:lua_tree_width = 30
let g:lua_tree_auto_close = 1 " closes the tree when it's the last window
let g:lua_tree_quit_on_open = 1 " closes the tree when you open a file
let g:lua_tree_follow = 1 " this option allows the cursor to be updated when entering a buffer
let g:lua_tree_indent_markers = 1 " this option shows indent markers when folders are open
let g:lua_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:lua_tree_allow_resize = 1 " will not resize the tree when opening a file
let g:lua_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }
let g:lua_tree_bindings = {
    \ 'edit':            ['<CR>', 'l'],
    \ 'edit_vsplit':     '<C-v>',
    \ 'edit_split':      '<C-x>',
    \ 'close_node':      ['<S-CR>', 'h'],
    \ 'refresh':         'R',
    \ 'create':          'a',
    \ 'remove':          'd',
    \ 'rename':          'r',
    \ 'cut':             'x',
    \ 'copy':            'y',
    \ 'paste':           'p',
    \ }
let g:lua_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': ""
    \   }
    \ }
Plug 'AndrewRadew/splitjoin.vim'
nmap gj :SplitjoinJoin<cr>
nmap gs :SplitjoinSplit<cr>
" vim in browser inputs
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" remove statusline for nvim in browser to have more space
if exists('g:started_by_firenvim')
  let fc['*'] = { 'takeover': 'never' }
  set laststatus=0
  au BufEnter github.com_*.txt set filetype=markdown
  " Enable hotkeys for Russian layout
  set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
  " to be able to exit on rus
  map <C-й> <C-q>
else
  set laststatus=2
endif
