Plug 'rbong/vim-crystalline'

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! StatusLine(...)
  return crystalline#mode() . crystalline#right_mode_sep('')
        \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill') . '%='
        \ . crystalline#left_sep('', 'Fill') . '%{StatusDiagnostic()} %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
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
Plug 'ap/vim-css-color'
