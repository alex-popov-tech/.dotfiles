" tabline and statusline
Plug 'rbong/vim-crystalline'
function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        return '[' . luaeval("require('lsp-status').status()") . ']'
    endif
    return ''
endfunction

function! StatusLine(...)
  return crystalline#mode() . crystalline#right_mode_sep('')
        \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill') . '%='
        \ . crystalline#left_sep('', 'Fill')
        \ . ' '
        \ . '%{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}]'
        \ . ' '
        \ . '%{FugitiveHead()}'
        \ . ' '
        \ . '%{LspStatus()}'
endfunction
let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'crystalline_statusline'

function! TabLine()
  return crystalline#bufferline()
endfunction
let g:crystalline_tabline_fn = 'TabLine'
set showtabline=2

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate all'}
Plug 'tjdevries/colorbuddy.vim'
Plug 'npxbr/gruvbox.nvim'
