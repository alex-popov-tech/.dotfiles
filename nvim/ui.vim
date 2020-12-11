syntax on
set termguicolors
set background=dark

" colorscheme gruvbox-material
lua require('colorbuddy').colorscheme('gruvbox')

hi DiffAdd    cterm=none ctermfg=none ctermbg=none gui=none guifg=#5fd700 guibg=none
hi DiffText   cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none
hi DiffChange cterm=none ctermfg=none ctermbg=none gui=none guifg=#ffff00 guibg=none
hi DiffDelete cterm=none ctermfg=none ctermbg=none gui=none guifg=#ff0000 guibg=none

hi LuaTreeFileNew   cterm=none ctermfg=none ctermbg=none gui=none guifg=#5fd700 guibg=none
hi LuaTreeFileDirty   cterm=none ctermfg=none ctermbg=none gui=none guifg=#ffff00 guibg=none
hi LuaTreeFileRenamed   cterm=none ctermfg=none ctermbg=none gui=none guifg=#ffff00 guibg=none
hi LuaTreeFileMerge   cterm=none ctermfg=none ctermbg=none gui=none guifg=#ff0000 guibg=none
hi LuaTreeFileStaged   cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none
