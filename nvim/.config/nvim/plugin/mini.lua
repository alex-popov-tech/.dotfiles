-- mini.nvim — editor ergonomics suite (surround, move, ai, bufremove, icons)
local defer = require("defer")
-- deferred via vim.schedule. mini.icons is also declared in plugin/lsp.lua
-- and plugin/fzf.lua (vim.pack.add is idempotent).

defer.later(function()
  vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

  require("mini.icons").setup({})

  require("mini.surround").setup()

  require("mini.move").setup({
    mappings = {
      -- move visual selection with Shift+hjkl
      left = "H",
      right = "L",
      down = "J",
      up = "K",
      -- disable line-move in normal mode
      line_left = "",
      line_right = "",
      line_down = "",
      line_up = "",
    },
  })

  require("mini.ai").setup({
    search_method = "cover_or_nearest",
  })

  require("mini.bufremove").setup({})
  vim.api.nvim_create_user_command("BDelete", function()
    require("mini.bufremove").delete()
  end, { desc = "Delete buffer (keep window layout)" })
  vim.keymap.set("ca", "bd", "BDelete")

  require("mini.notify").setup({})
  vim.notify = require("mini.notify").make_notify()
end)
