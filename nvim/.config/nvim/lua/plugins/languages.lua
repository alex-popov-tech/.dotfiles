return {
  -- {
  --   "ray-x/go.nvim",
  --   enabled = false,
  --   dependencies = { -- optional packages
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --     "mfussenegger/nvim-dap",
  --     "leoluz/nvim-dap-go",
  --     "rcarriga/nvim-dap-ui",
  --   },
  --   config = function()
  --     require("go").setup()
  --   end,
  --   event = { "CmdlineEnter" },
  --   ft = { "go", "gomod" },
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  -- },
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact" },
    config = function()
      require("ts-error-translator").setup()
    end,
  },
}
