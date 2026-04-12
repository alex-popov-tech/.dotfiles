-- file explorers
local defer = require("defer")


-- oil.nvim — edit the filesystem like a buffer
defer.later(function()
  vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-mini/mini.icons",
  })

  require("oil").setup({
    float = {
      padding = 2,
      max_width = 80,
      max_height = 30,
    },
    view_options = {
      show_hidden = true,
    },
    watch_for_changes = true,
    columns = {
      "icon",
      "size",
      "mtime",
    },
    keymaps = {
      ["?"] = "actions.show_help",
      ["<BS>"] = "actions.parent",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["q"] = "actions.close",
    },
  })

  vim.keymap.set("n", "<C-f>", function()
    local oil = require("oil")
    oil.toggle_float(oil.get_current_dir())
  end, { desc = "Toggle oil file browser" })
end)


-- fyler.nvim — file browser (:Fyler)
defer.on_cmd({ "Fyler" }, function()
  vim.pack.add({
    "https://github.com/A7Lavinraj/fyler.nvim",
    "https://github.com/nvim-mini/mini.icons",
  })
  require("fyler").setup({})
end)
