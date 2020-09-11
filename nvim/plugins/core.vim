" main text objects plugin
Plug 'kana/vim-textobj-user'
" dac dic yic cic
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
function! InitAbbreviations()
  " abbreviations
  Abolish! -cmdline co{snt,tsn,tns,nts} co{nst}
  Abolish! -cmdline fun{cton, ctino, ctoin} fun{ction}
  Abolish! -cmdline ret{utn,nurn} ret{urn}
  Abolish! -cmdline f{ro} f{or}
  Abolish! -cmdline aw{ati,tai,tia} aw{ait}
  Abolish! -cmdline len{ght} len{gth}
  Abolish! -cmdline shou{dl} shou{ld}
  Abolish! -cmdline tr{eu} tr{ue}
endfunction
autocmd VimEnter * call InitAbbreviations()

" add bunch of mappings like ]p ]e ]<space> etc.
Plug 'tpope/vim-unimpaired'
" paste with indenting respected
Plug 'sickill/vim-pasta'
" allows repeat via dot for some plugins like surround
Plug 'tpope/vim-repeat'
" add\update\remove surround stuff like '"{}"'
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
let g:sandwich#recipes = [
      \ { 'buns': ['\s\+', '\s\+'], 'regex': 1, 'kind': ['delete', 'replace', 'query'], 'input': [' '] },
      \ { 'buns': ['', ''], 'action': ['add'], 'motionwise': ['line'], 'linewise': 1, 'input': ["\<CR>"] },
      \ { 'buns': ['^$', '^$'], 'regex': 1, 'linewise': 1, 'input': ["\<CR>"] },
      \ { 'buns': ['<', '>'], 'expand_range': 0, 'input': ['>', 'a'], },
      \ { 'buns': ['`', '`'], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'match_syntax': 1, },
      \ { 'buns': ['"', '"'], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'match_syntax': 1, },
      \ { 'buns': ["'", "'"], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'match_syntax': 1, },
      \ { 'buns': ['{', '}'], 'nesting': 1, 'skip_break': 1, 'input': ['{', '}', 'B'], },
      \ { 'buns': ['[', ']'], 'nesting': 1, 'input': ['[', ']', 'r'], },
      \ { 'buns': ['(', ')'], 'nesting': 1, 'input': ['(', ')', 'b'], },
      \ { 'buns': 'sandwich#magicchar#t#tag()', 'listexpr': 1, 'kind': ['add'], 'action': ['add'], 'input': ['t'], },
      \ { 'buns': 'sandwich#magicchar#t#tag()', 'listexpr': 1, 'kind': ['replace'], 'action': ['add'], 'input': ['T', '<'], },
      \ { 'buns': 'sandwich#magicchar#t#tagname()', 'listexpr': 1, 'kind': ['replace'], 'action': ['add'], 'input': ['t'], },
      \ { 'external': ['it', 'at'], 'noremap': 1, 'kind': ['delete', 'textobj'], 'expr_filter': ['operator#sandwich#kind() !=# "replace"'], 'synchro': 1, 'linewise': 1, 'input': ['t', 'T', '<'], },
      \ { 'external': ['it', 'at'], 'noremap': 1, 'kind': ['replace', 'query'], 'expr_filter': ['operator#sandwich#kind() ==# "replace"'], 'synchro': 1, 'input': ['T', '<'], },
      \ { 'external': ["\<Plug>(textobj-sandwich-tagname-i)", "\<Plug>(textobj-sandwich-tagname-a)"], 'noremap': 0, 'kind': ['replace', 'textobj'], 'expr_filter': ['operator#sandwich#kind() ==# "replace"'], 'synchro': 1, 'input': ['t'], },
      \ { 'buns': ['sandwich#magicchar#f#fname()', '")"'], 'kind': ['add', 'replace'], 'action': ['add'], 'expr': 1, 'input': ['f'] },
      \ { 'external': ["\<Plug>(textobj-sandwich-function-ip)", "\<Plug>(textobj-sandwich-function-i)"], 'noremap': 0, 'kind': ['delete', 'replace', 'query'], 'input': ['f'] },
      \ { 'external': ["\<Plug>(textobj-sandwich-function-ap)", "\<Plug>(textobj-sandwich-function-a)"], 'noremap': 0, 'kind': ['delete', 'replace', 'query'], 'input': ['F'] },
      \ { 'buns': 'sandwich#magicchar#i#input("operator")', 'kind': ['add', 'replace'], 'action': ['add'], 'listexpr': 1, 'input': ['i'], },
      \ { 'buns': 'sandwich#magicchar#i#input("textobj", 1)', 'kind': ['delete', 'replace', 'query'], 'listexpr': 1, 'regex': 1, 'synchro': 1, 'input': ['i'], },
      \ { 'buns': 'sandwich#magicchar#i#lastinput("operator", 1)', 'kind': ['add', 'replace'], 'action': ['add'], 'listexpr': 1, 'input': ['I'], },
      \ { 'buns': 'sandwich#magicchar#i#lastinput("textobj")', 'kind': ['delete', 'replace', 'query'], 'listexpr': 1, 'regex': 1, 'synchro': 1, 'input': ['I'], },
      \ { 'buns': ['(', ')'], 'cursor': 'head', 'command': ['startinsert'], 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['f'] },
      \ ]
" automatically adjust shiftwidth/expandtab/etc
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
nmap gs :Gstatus<cr>
nmap gp :Gpush<cr>
" provides f/t - like thing but with s{firstletter}{secontLetter}
" as well with text object like dzke - delete till 'ke'
" Plug 'justinmk/vim-sneak'
" let g:sneak#s_next = 0
" auto placing paired signs like {} [] '' "" etc
Plug 'jiangmiao/auto-pairs'
" find/jump definition/reference with fzf
Plug 'pechorin/any-jump.vim'
nmap go :AnyJump<cr>
Plug 'mhinz/vim-startify'
let g:startify_session_dir = '~/.vim/sessions/'
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ ]
" use vsc root when enter file
let g:startify_change_to_vcs_root = 1
" do not show 'edit' and 'quit' options
let g:startify_enable_special = 1
" start from 1 when choosing
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
" text object camel case word
Plug 'chaoren/vim-wordmotion'
let g:wordmotion_prefix = ','
" when navigate to previously opened files - open in last file position
Plug 'farmergreg/vim-lastplace'
" kill all buffers but current
Plug 'schickling/vim-bufonly'
" open terminal in floating window
Plug 'voldikss/vim-floaterm'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8
noremap  <F11> :FloatermToggle<CR>
tnoremap <F11> <C-\><C-n>:FloatermToggle<CR>
Plug 'svermeulen/vim-subversive'
nmap m <plug>(SubversiveSubstitute)
nmap mm <plug>(SubversiveSubstituteLine)
" gS to split things, gJ to join them together
Plug 'andrewradev/splitjoin.vim'
