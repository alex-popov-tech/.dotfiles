local defer = require("defer")

-- Navigator.nvim — seamless navigation between neovim splits and wezterm panes
defer.later(function()
  vim.pack.add({ "https://github.com/numToStr/Navigator.nvim" })

  local ok, wezterm = pcall(function()
    return require("Navigator.mux.wezterm"):new()
  end)
  require("Navigator").setup({ mux = ok and wezterm or "auto" })

  vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>NavigatorLeft<cr>")
  vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>NavigatorRight<cr>")
  vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>NavigatorUp<cr>")
  vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>NavigatorDown<cr>")
end)


-- smart-splits.nvim + submode.nvim — <C-w>r enters resize mode for splits
defer.later(function()
  vim.pack.add({
    "https://github.com/mrjones2014/smart-splits.nvim",
    "https://github.com/pogyomo/submode.nvim",
  })

  local submode = require("submode")
  submode.create("smart-splits", {
    mode = "n",
    enter = "<C-w>r",
    leave = { "<Esc>", "q", "<C-c>" },
    hook = {
      on_enter = function()
        vim.notify("Use { l, d, u, r } to resize the window")
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
end)
