-- UI enhancements
local defer = require("defer")

-- nvim-highlight-colors — show color values as inline swatches (tailwind aware)
defer.later(function()
  vim.pack.add({ "https://github.com/brenoprata10/nvim-highlight-colors" })
  require("nvim-highlight-colors").setup({
    render = "virtual",
    enable_tailwind = true,
  })
end)

-- neoscroll.nvim — animated scrolling (easing curves for C-u/C-d/etc.)
defer.later(function()
  vim.pack.add({ "https://github.com/karb94/neoscroll.nvim" })
  require("neoscroll").setup({
    hide_cursor = true,
    duration_multiplier = 0.75,
    mappings = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-y>",
      "<C-e>",
      "zt",
      "zz",
      "zb",
    },
  })
end)

defer.later(function()
  vim.pack.add({ "https://github.com/rachartier/tiny-cmdline.nvim" })
  require("vim._core.ui2").enable({})
  vim.o.cmdheight = 0
  require("tiny-cmdline").setup({
    native_types = {},
  })
end)

-- smear-cursor.nvim — animated cursor trail (disabled)
-- defer.later(function()
--   vim.pack.add({ "https://github.com/sphamba/smear-cursor.nvim" })
--   require("smear_cursor").setup({ stiffness = 0.7 })
-- end)
