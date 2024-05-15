return {
  {
    "SuperBo/fugit2.nvim",
    opts = { width = "80%", height = "80%" },
    cmd = { "Fugit2", "Fugit2Graph" },
    keys = { { "<leader>F", mode = "n", "<cmd>Fugit2<cr>" } },
    init = function()
      vim.cmd("cnoreabbrev git Fugit2")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      {
        -- optional: for diffview.nvim integration
        "sindrets/diffview.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- lazy, only load diffview by these commands
        cmd = {
          "DiffviewFileHistory",
          "DiffviewOpen",
          "DiffviewToggleFiles",
          "DiffviewFocusFiles",
          "DiffviewRefresh",
        },
      },
      {
        "chrisgrieser/nvim-tinygit", -- optional: for Github PR view
        dependencies = { "stevearc/dressing.nvim" },
      },
    },
  },

  {
    "kndndrj/nvim-dbee",
    cmd = { "Dbee" },
    dependencies = { "MunifTanjim/nui.nvim" },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    init = function()
      vim.cmd("cnoreabbrev db Dbee")
    end,
    config = function()
      require("dbee").setup( --[[optional config]])
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
    end,
  },
}
