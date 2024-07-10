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

  {
    "robitx/gp.nvim",
    event = "VeryLazy",
    opts = {
      openai_api_key = { "cat", "/Users/alex/.openapi" },
    },
    config = function(_, opts)
      local gp = require("gp")
      gp.setup(opts)
      gp._state.chat_agent = "ChatGPT4"
      vim.cmd("cnoreabbrev gp GpChatNew popup")
    end,
  },
}
