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

  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim", lazy = true },
  --     {
  --       "echasnovski/mini.icons",
  --       version = false,
  --       lazy = true,
  --       config = function()
  --         require("mini.icons").setup()
  --         MiniIcons.mock_nvim_web_devicons()
  --       end,
  --     },
  --     "MunifTanjim/nui.nvim",
  --   },
  --   keys = { { "<c-f>", "<cmd>Neotree reveal<cr>" } },
  --   cmd = { "Neotree" },
  --   init = function()
  --     vim.cmd("cnoreabbrev filetree Neotree source=filesystem reveal=true position=float")
  --   end,
  --   opts = {
  --     close_if_last_window = true,
  --     popup_border_style = "rounded",
  --     filesystem = {
  --       filtered_items = {
  --         visible = true, -- when true, they will just be displayed differently than normal items
  --         hide_dotfiles = true,
  --         hide_gitignored = true,
  --         hide_hidden = true,
  --       },
  --     },
  --     window = {
  --       position = "float",
  --       -- width = "90%",
  --       mapping_options = {
  --         noremap = true,
  --         nowait = true,
  --       },
  --       mappings = {
  --         ["<bs>"] = "close_node",
  --         ["/"] = "",
  --       },
  --     },
  --   },
  -- },
}
