" file explorer
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
            \ 'coc-explorer',
            \ 'coc-git',
            \]
" toggle explorer
nmap <C-f> :CocCommand explorer --preset floating<CR>
let g:coc_explorer_global_presets = {
            \   'floating': {
            \     'position': 'floating',
            \     'floating-position': 'center',
            \     'floating-width': 120,
            \     'open-action-strategy': 'sourceWindow'
            \   }
            \ }
" add commenting for different langs via gcc
Plug 'tpope/vim-commentary'
" plugin which allows vim to work with common editorconfig
Plug 'editorconfig/editorconfig-vim'
" database viewer
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
" rainbow brackets
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
" main lsp plugin to enable servers communication
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
" plugin to add completeion possibility
Plug 'nvim-lua/completion-nvim'
let g:completion_chain_complete_list = {
    \ 'default': [ {'complete_items': ['lsp', 'tabnine', 'buffers' ] } ],
    \ 'sql': [ {'complete_items': ['vim-dadbod-completion'] } ],
\}
let g:completion_items_priority = {
        \ 'Field': 10,
        \ 'Method': 10,
        \ 'Function': 9,
        \ 'Variables': 9,
        \ 'Constant': 9,
        \ 'Interfaces': 8,
        \ 'Class': 8,
        \ 'Struct': 8,
        \ 'Keyword': 8,
        \ 'Treesitter': 8,
        \ 'TabNine' : 8,
        \ 'vim-vsnip' : 7,
        \ 'Buffers' : 1,
        \ 'File' : 2,
        \}
let g:completion_sorting = "length"
let g:completion_matching_strategy_list = ['exact', 'fuzzy']
let g:completion_matching_smart_case = 1
" let g:completion_auto_change_source = 1
Plug 'steelsojka/completion-buffers'
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'aca/completion-tabnine', { 'do': 'version=3.1.9 ./install.sh' }
let g:completion_tabnine_priority = 5
let g:completion_tabnine_sort_by_details=1
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" better messages
set shortmess+=s
" TextEdit might fail if hidden is not set.
" set hidden
