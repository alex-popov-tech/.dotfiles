syntax on
set termguicolors
set background=dark

" colorscheme gruvbox-material
lua require('colorbuddy').colorscheme('gruvbox')

hi DiffAdd    cterm=none ctermfg=none ctermbg=none gui=none guifg=#5fd700 guibg=none
hi DiffText   cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none
hi DiffChange cterm=none ctermfg=none ctermbg=none gui=none guifg=#ffff00 guibg=none
hi DiffDelete cterm=none ctermfg=none ctermbg=none gui=none guifg=#ff0000 guibg=none

hi CocExplorerFileDiagnosticError cterm=none ctermfg=none ctermbg=none gui=none guifg=#ff0000 guibg=none
hi CocExplorerFilenameDiagnosticError cterm=none ctermfg=none ctermbg=none gui=none guifg=#ff0000 guibg=none
hi CocExplorerFileDiagnosticWarning cterm=none ctermfg=none ctermbg=none gui=none guifg=#fff000 guibg=none
hi CocExplorerFilenameDiagnosticWarning cterm=none ctermfg=none ctermbg=none gui=none guifg=#fff000 guibg=none
hi CocExplorerGitPathChange   cterm=none ctermfg=none ctermbg=none gui=none guifg=#5fd700 guibg=none
hi CocExplorerGitContentChange   cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none
hi CocExplorerGitDeleted cterm=none ctermfg=none ctermbg=none gui=none guifg=#ff0000 guibg=none
