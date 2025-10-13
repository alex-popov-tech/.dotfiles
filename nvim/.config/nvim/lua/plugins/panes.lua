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
    dependencies = { "pogyomo/submode.nvim" },
    keys = {
      {
        "<C-w>",
        function()
          local submode = require("submode")
          submode.enter("smart-splits")
        end,
        mode = { "n" },
      },
    },
    config = function()
      -- Resize
      local submode = require("submode")
      submode.create("smart-splits", {
        mode = "n",
        enter = "<C-w>r",
        leave = { "<Esc>", "q", "<C-c>" },
        hook = {
          on_enter = function()
            vim.notify("Use { h, j, k, l } or { <Left>, <Down>, <Up>, <Right> } to resize the window")
          end,
          on_leave = function()
            vim.notify("")
          end,
        },
        default = function(register)
          register("l", require("smart-splits").resize_left, { desc = "Resize left" })
          register("d", require("smart-splits").resize_down, { desc = "Resize down" })
          register("u", require("smart-splits").resize_up, { desc = "Resize up" })
          register("r", require("smart-splits").resize_right, { desc = "Resize right" })
        end,
      })
    end,
  },
}
