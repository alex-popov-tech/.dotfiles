return {
  -- navigate splits
  {
    "numToStr/Navigator.nvim",
    keys = {
      { "<C-h>", "<CMD>NavigatorLeft<CR>", mode = { "n", "t" } },
      { "<C-l>", "<CMD>NavigatorRight<CR>", mode = { "n", "t" } },
      { "<C-k>", "<CMD>NavigatorUp<CR>", mode = { "n", "t" } },
      { "<C-j>", "<CMD>NavigatorDown<CR>", mode = { "n", "t" } },
    },
    config = function()
      local ok, wezterm = pcall(function()
        return require("Navigator.mux.wezterm"):new()
      end)
      require("Navigator").setup({ mux = ok and wezterm or "auto" })
    end,
  },

  -- split resize mode
  {
    "mrjones2014/smart-splits.nvim",
    keys = { {
      "<c-w>",
      function()
        require("smart-splits").start_resize_mode()
      end,
    } },
    opts = {
      resize_mode = {
        quit_key = "<ESC>",
        resize_keys = { "l", "d", "u", "r" },
        silent = true,
        hooks = {
          on_enter = function()
            vim.notify("Entering resize mode")
          end,
          on_leave = function()
            vim.notify("Exiting resize mode, bye")
          end,
        },
      },
      default_amount = 5,
    },
  },
}
