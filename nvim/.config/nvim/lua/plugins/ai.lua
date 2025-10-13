return {
  {
    -- alternative to https://github.com/Exafunction/codeium.nvim
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocidium = require("neocodeium")
      neocidium.setup()
      vim.keymap.set("i", "<A-a>", neocidium.accept)
      vim.keymap.set("i", "<A-e>", neocidium.accept_line)
      vim.keymap.set("i", "<A-w>", function()
        neocidium.cycle_or_complete(1)
      end)
      vim.keymap.set("i", "<A-u>", function()
        neocidium.cycle_or_complete(-1)
      end)
    end,
  },
}

