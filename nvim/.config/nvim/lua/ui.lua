g.nvcode_termcolors = 256 -- true colors

g.sonokai_style = "shusia"
g.sonokai_enable_italic = 1
cmd("colorscheme sonokai")

-- highlight split separators
hi("VertSplit", {guibg = "none", guifg = "#78dce8"})
hi("StatusLineNC", {guibg = "none", guifg = "#78dce8"})
hi("StatusLine", {guibg = "none", guifg = "#78dce8"})
-- custom highlights for fugitive
hi("DiffAdd", {guifg = "#5fd700"})
hi("DiffText", {guifg = "#00afff"})
hi("DiffChange", {guifg = "#ffff00"})
hi("DiffDelete", {guifg = "#ff0000"})

-- custom highlights for fugitive
hi("NvimTreeGitNew", {guifg = "#5fd700"})
hi("NvimTreeGitDirty", {guifg = "#ffff00"})
hi("NvimTreeGitRenamed", {guifg = "#ffff00"})
hi("NvimTreeGitMerge", {guifg = "#ff0000"})
hi("NvimTreeGitStaged", {guifg = "#00afff"})

-- hl groups for diagnostic & float
hi("DiagnosticVirtualTextWarn", {guifg = "#e7c664", guibg = "none"})
hi("DiagnosticVirtualTextError", {guifg = "#fc5d7c", guibg = "none"})
hi("DiagnosticFloatingError", {guifg = "#fc5d7c", guibg = "none"})
hi("DiagnosticFloatingWarn", {guifg = "#e7c664", guibg = "none"})
hi("NormalFloat", {guibg = "none"})

