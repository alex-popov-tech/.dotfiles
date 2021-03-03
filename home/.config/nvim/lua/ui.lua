g.nvcode_termcolors = 256 -- true colors
cmd("colorscheme sonokai")

-- highlight modified buffers for tabline
hi("BufferCurrentMod", {guifg="#00afff"})
hi("BufferVisibleMod", {guifg="#00afff"})
hi("BufferInactiveMod", {guifg="#00afff"})

-- custom highlights for fugitive
hi("DiffAdd", {guifg="#5fd700"})
hi("DiffText", {guifg="#00afff"})
hi("DiffChange", {guifg="#ffff00"})
hi("DiffDelete", {guifg="#ff0000"})

-- custom highlights for fugitive
hi("NvimTreeGitNew", {guifg="#5fd700"})
hi("NvimTreeGitDirty", {guifg="#ffff00"})
hi("NvimTreeGitRenamed", {guifg="#ffff00"})
hi("NvimTreeGitMerge", {guifg="#ff0000"})
hi("NvimTreeGitStaged", {guifg="#00afff"})
