vim.g.catppuccin_flavour = 'macchiato'
cmd('colorscheme catppuccin')
hi('ColorColumn', {guibg = 'none'})
-- highlight split separators
hi("VertSplit", {guibg = "none", guifg = "#7DC4E4"})
-- hi("StatusLineNC", {guibg = "none", guifg = "#81A1C1"})
-- hi("StatusLine", {guibg = "none", guifg = "#81A1C1"})

-- hl groups for diagnostic & float
hi("DiagnosticVirtualTextWarn", {guifg = "#e7c664", guibg = "none"})
hi("DiagnosticVirtualTextError", {guifg = "#fc5d7c", guibg = "none"})
hi("DiagnosticVirtualTextHint", {guibg = "none"})
hi("LspInlayHint", {guibg = "none"})
hi("DiagnosticFloatingError", {guifg = "#fc5d7c", guibg = "none"})
hi("DiagnosticFloatingWarn", {guifg = "#e7c664", guibg = "none"})
-- hi("NormalFloat", {guibg = "none"})
hi("SpellBad", { guifg = "#fc5d7c" })
-- make cursor line and column of the same color
cmd("hi! link CursorLine CursorColumn")
