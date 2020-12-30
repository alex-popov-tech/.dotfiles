call plug#begin('~/.config/nvim/plugged')
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
luafile ~/.config/nvim/lua/plugins/vim-fugitive.lua
" auto placing paired signs like {} [] '' "" etc
Plug 'cohama/lexima.vim'
" when navigate to previously opened files - open in last file position
Plug 'farmergreg/vim-lastplace'
" start screen
Plug 'mhinz/vim-startify'
luafile ~/.config/nvim/lua/plugins/vim-startify.lua
" text object camel case word
Plug 'chaoren/vim-wordmotion'
luafile ~/.config/nvim/lua/plugins/vim-wordmotion.lua
" open terminal in floating window
Plug 'voldikss/vim-floaterm'
luafile ~/.config/nvim/lua/plugins/vim-floaterm.lua
Plug 'svermeulen/vim-subversive'
luafile ~/.config/nvim/lua/plugins/vim-subversive.lua
" icons for lua
Plug 'kyazdani42/nvim-web-devicons'
" file tree
Plug 'kyazdani42/nvim-tree.lua'
luafile ~/.config/nvim/lua/plugins/nvim-tree.lua
Plug 'AndrewRadew/splitjoin.vim'
luafile ~/.config/nvim/lua/plugins/splitjoin.lua
" plugin for vim-tmux interactions
Plug 'christoomey/vim-tmux-navigator'
luafile ~/.config/nvim/lua/plugins/vim-tmux-navigator.lua
" resizing windows
Plug 'talek/obvious-resize'
luafile ~/.config/nvim/lua/plugins/obvious-resize.lua
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" fzf commands for lsp sources
Plug 'gfanto/fzf-lsp.nvim'
" find/jump definition/reference with fzf
Plug 'pechorin/any-jump.vim'
Plug 'stsewd/fzf-checkout.vim'
luafile ~/.config/nvim/lua/plugins/fzf.lua
" add commenting for different langs via gcc
Plug 'tpope/vim-commentary'
" plugin which allows vim to work with common editorconfig
Plug 'editorconfig/editorconfig-vim'
" database viewer
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
" main lsp plugin to enable servers communication
" top buff line
Plug 'romgrk/barbar.nvim'
luafile ~/.config/nvim/lua/plugins/barbar-nvim.lua
" statusline
Plug 'glepnir/galaxyline.nvim'
" parser
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate all'}
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'neovim/nvim-lspconfig'
" plugin to add completeion possibility
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'aca/completion-tabnine', { 'do': 'version=3.1.9 ./install.sh' }
luafile ~/.config/nvim/lua/plugins/completion-nvim.lua
call plug#end()
luafile ~/.config/nvim/lua/plugins/galaxyline-nvim.lua
luafile ~/.config/nvim/lua/plugins/nvim-treesitter.lua
luafile ~/.config/nvim/lua/plugins/color-schemes.lua
luafile ~/.config/nvim/lua/lsp.lua

" highlight modified buffers
hi BufferCurrentMod cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none
hi BufferVisibleMod cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none
hi BufferInactiveMod cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none


" custom highlights for vim-fugitive
hi DiffAdd    cterm=none ctermfg=none ctermbg=none gui=none guifg=#5fd700 guibg=none
hi DiffText   cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none
hi DiffChange cterm=none ctermfg=none ctermbg=none gui=none guifg=#ffff00 guibg=none
hi DiffDelete cterm=none ctermfg=none ctermbg=none gui=none guifg=#ff0000 guibg=none

" custom highlights for vim-fugitive
hi LuaTreeFileNew   cterm=none ctermfg=none ctermbg=none gui=none guifg=#5fd700 guibg=none
hi LuaTreeFileDirty   cterm=none ctermfg=none ctermbg=none gui=none guifg=#ffff00 guibg=none
hi LuaTreeFileRenamed   cterm=none ctermfg=none ctermbg=none gui=none guifg=#ffff00 guibg=none
hi LuaTreeFileMerge   cterm=none ctermfg=none ctermbg=none gui=none guifg=#ff0000 guibg=none
hi LuaTreeFileStaged   cterm=none ctermfg=none ctermbg=none gui=none guifg=#00afff guibg=none
