return {

  {
    -- alternative to https://github.com/Exafunction/codeium.nvim
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local it = require("neocodeium")
      it.setup()
      vim.keymap.set("i", "<A-a>", it.accept)
      vim.keymap.set("i", "<A-e>", it.accept_line)
      vim.keymap.set("i", "<A-w>", function()
        it.cycle_or_complete(1)
      end)
      vim.keymap.set("i", "<A-u>", function()
        it.cycle_or_complete(-1)
      end)
    end,
  },
}
