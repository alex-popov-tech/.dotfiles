" debug vim runtime
Plug 'dstein64/vim-startuptime'
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
Plug 'numtostr/FTerm.nvim'
lua require'FTerm'.setup({ dimensions  = { height = 0.8, width = 0.9, row = 0.5, col = 0.5 } })
lua vim.fn.nvim_set_keymap('n', '<F11>', '<CMD>lua require"FTerm".toggle()<CR>', { noremap = true, silent = true })
lua vim.fn.nvim_set_keymap('t', '<F11>', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>', { noremap = true, silent = true })
Plug 'svermeulen/vim-subversive'
nmap m <plug>(SubversiveSubstitute)
nmap mm <plug>(SubversiveSubstituteLine)
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
