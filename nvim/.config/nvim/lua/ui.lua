require'onenord'.setup({
    theme = 'dark',
    borders = true,
    disable = {background = true},
    custom_highlights = {
      StatusLineNC = { bg = "none", fg = "#81A1C1" },
      StatusLine = { bg = "none", fg = "#81A1C1" },
      VertSplit = { bg = "none", fg = "#81A1C1" },
      CursorLineNr = { bg = "none", fg = "#88C0D0" },
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
    }
})
hi("ColorColumn", {guibg = "none"})
-- highlight split separators
-- hi("VertSplit", {guibg = "none", guifg = "#81A1C1"})
-- hi("StatusLineNC", {guibg = "none", guifg = "#81A1C1"})
-- hi("StatusLine", {guibg = "none", guifg = "#81A1C1"})

-- custom highlights for fugitive
-- hi("DiffAdd", {guifg = "#5fd700"})
-- hi("DiffText", {guifg = "#00afff"})
-- hi("DiffChange", {guifg = "#ffff00"})
-- hi("DiffDelete", {guifg = "#ff0000"})

-- custom highlights for fugitive
-- hi("NvimTreeGitNew", {guifg = "#5fd700"})
-- hi("NvimTreeGitDirty", {guifg = "#ffff00"})
-- hi("NvimTreeGitRenamed", {guifg = "#ffff00"})
-- hi("NvimTreeGitMerge", {guifg = "#ff0000"})
-- hi("NvimTreeGitStaged", {guifg = "#00afff"})

-- hl groups for diagnostic & float
-- hi("DiagnosticVirtualTextWarn", {guifg = "#e7c664", guibg = "none"})
-- hi("DiagnosticVirtualTextError", {guifg = "#fc5d7c", guibg = "none"})
-- hi("DiagnosticFloatingError", {guifg = "#fc5d7c", guibg = "none"})
-- hi("DiagnosticFloatingWarn", {guifg = "#e7c664", guibg = "none"})
-- hi("NormalFloat", {guibg = "none"})
