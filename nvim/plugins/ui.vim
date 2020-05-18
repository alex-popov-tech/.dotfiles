Plug 'rbong/vim-crystalline'

function! StatusLine(...)
  return crystalline#mode() . crystalline#right_mode_sep('')
        \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill') . '%='
        \ . crystalline#left_sep('', 'Fill') . ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
endfunction
let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'crystalline_gruvbox'
set laststatus=2

function! TabLine()
  return crystalline#bufferline()
endfunction

let g:crystalline_tabline_fn = 'TabLine'
set showtabline=2

Plug 'gruvbox-community/gruvbox'
let g:gruvbox_contrast_dark = "light"
let g:gruvbox_sign_column = "bg0"

" show color in buffer on special formats like #XXXXXX
Plug 'ap/vim-css-color'
