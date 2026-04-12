-- core editor plugins — essential ergonomics and editing improvements.
local defer = require("defer")


-- ts-comments — treesitter-aware commentstring for neovim's built-in gc/gcc
defer.later(function()
  vim.pack.add({ "https://github.com/folke/ts-comments.nvim" })
  require("ts-comments").setup({})
end)


-- vim-matchup — bracket/keyword matching enhancements (%)
defer.later(function()
  vim.pack.add({ "https://github.com/andymass/vim-matchup" })
end)


-- vim-unimpaired — ]p ]e ]<space> etc. paired mappings
defer.later(function()
  vim.pack.add({ "https://github.com/tpope/vim-unimpaired" })
end)


-- vim-repeat — dot-repeat support for plugin mappings (surround, etc.)
defer.later(function()
  vim.pack.add({ "https://github.com/tpope/vim-repeat" })
end)


-- YankAssassin — cursor stays in place after yank
defer.later(function()
  vim.pack.add({ "https://github.com/svban/YankAssassin.vim" })
end)


-- smart-paste — auto-adjust indent on paste
defer.later(function()
  vim.pack.add({ "https://github.com/nemanjamalesija/smart-paste.nvim" })
  require("smart-paste").setup({})
end)


-- vim-fugitive — git commands (:Git, :Gblame, :Gdiff, etc.)
defer.later(function()
  vim.pack.add({ "https://github.com/tpope/vim-fugitive" })
end)


-- vim-textobj-user — framework for custom text objects
defer.later(function()
  vim.pack.add({ "https://github.com/kana/vim-textobj-user" })
end)


-- vim-textobj-variable-segment — av/iv for camelCase/snake_case word segments
defer.later(function()
  vim.pack.add({ "https://github.com/Julian/vim-textobj-variable-segment" })
end)


-- substitute.nvim — replace without yanking deleted text
defer.later(function()
  vim.pack.add({ "https://github.com/gbprod/substitute.nvim" })
  require("substitute").setup({})

  vim.keymap.set({ "n", "x" }, "m", function() require("substitute").operator() end)
  vim.keymap.set({ "n", "x" }, "mm", function() require("substitute").line() end)
  vim.keymap.set({ "n", "x" }, "M", function() require("substitute").eol() end)
end)
