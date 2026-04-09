return {
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    cmd = { "OilReveal", "Oil" },
    keys = {
      {
        "<c-f>",
        function()
          local oil = require("oil")
          oil.toggle_float(oil.get_current_dir())
        end,
      },
    },
    opts = {
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 80,
        max_height = 30,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      view_options = {
        show_hidden = true,
      },
      watch_for_changes = true,
      columns = {
        -- "permissions",
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
    },
  },

  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    cmd = "Fyler",
    --lazy = false, -- Necessary for `default_explorer` to work properly
    opts = {},
  },
}
