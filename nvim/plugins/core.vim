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
Plug 'tpope/vim-surround'
" provides function of replacing from yank
Plug 'svermeulen/vim-subversive'
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
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
" moving selected lines
Plug 'matze/vim-move'
let g:move_map_keys = 0
vmap <silent> <Down> <Plug>MoveBlockDown
vmap <silent> <Up> <Plug>MoveBlockUp
vmap <silent> <Left> <Plug>MoveBlockLeft
vmap <silent> <Right> <Plug>MoveBlockRight
" when navigate to previously opened files - open in last file position
Plug 'farmergreg/vim-lastplace'
" kill all buffers but current
Plug 'schickling/vim-bufonly'
" open terminal in floating window
Plug 'voldikss/vim-floaterm'
noremap  <F11> :FloatermToggle<CR>
tnoremap <F11> <C-\><C-n>:FloatermToggle<CR>
