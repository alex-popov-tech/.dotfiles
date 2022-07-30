cmd('colorscheme catppuccin')
hi('ColorColumn', {guibg = 'none'})
-- highlight split separators
-- hi("VertSplit", {guibg = "none", guifg = "#81A1C1"})
-- hi("StatusLineNC", {guibg = "none", guifg = "#81A1C1"})
-- hi("StatusLine", {guibg = "none", guifg = "#81A1C1"})

-- hl groups for diagnostic & float
hi("DiagnosticVirtualTextWarn", {guifg = "#e7c664", guibg = "none"})
hi("DiagnosticVirtualTextError", {guifg = "#fc5d7c", guibg = "none"})
hi("DiagnosticFloatingError", {guifg = "#fc5d7c", guibg = "none"})
hi("DiagnosticFloatingWarn", {guifg = "#e7c664", guibg = "none"})
-- hi("NormalFloat", {guibg = "none"})
