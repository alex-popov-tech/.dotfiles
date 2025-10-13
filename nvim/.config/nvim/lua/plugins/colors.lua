return {

  {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        on_colors = function() end,
        on_highlights = function() end,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- {
  --   "rebelot/kanagawa.nvim",
  --   enabled = false,
  --   event = "UIEnter",
  --   config = function()
  --     vim.opt.fillchars:append({
  --       horiz = "━",
  --       horizup = "┻",
  --       horizdown = "┳",
  --       vert = "┃",
  --       vertleft = "┨",
  --       vertright = "┣",
  --       verthoriz = "╋",
  --     })
  --     require("kanagawa").setup({ transparent = true, globalStatus = true })
  --     -- load the colorscheme here
  --     -- vim.cmd("colorscheme kanagawa")
  --   end,
  -- },

  {
    "ellisonleao/gruvbox.nvim",
    event = "UIEnter",
    priority = 1000,
    config = function()
      -- Default options:
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })
      -- load the colorscheme here
      vim.cmd("colorscheme gruvbox")
      vim.cmd("hi WinSeparator guifg=#d3869b")
    end,
  },

  {
    "sainnhe/gruvbox-material",
    enabled = false,
    event = "UIEnter",
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = "hard"
      -- vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  -- highlight text as color
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = { render = "virtual", enable_tailwind = true },
  },
}
