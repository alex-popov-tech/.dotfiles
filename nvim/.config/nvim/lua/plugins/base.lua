return {
  -- add bunch of mappings like ]p ]e ]<space> etc.
  { "tpope/vim-unimpaired", event = "VeryLazy" },

  -- allows repeat via dot for some plugins like surround
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- after yank leave cursor on its place
  { "svban/YankAssassin.vim", event = "VeryLazy" },

  -- replace without yankink deleted
  {
    "gbprod/substitute.nvim",
    opts = {},
    keys = {
      {
        "m",
        function()
          require("substitute").operator()
        end,
        mode = { "n", "x" },
        { noremap = true },
      },
      {
        "mm",
        function()
          require("substitute").line()
        end,
        mode = { "n", "x" },
        { noremap = true },
      },
      {
        "M",
        function()
          require("substitute").eol()
        end,
        mode = { "n", "x" },
        { noremap = true },
      },
    },
  },

  -- live command preview
  {
    "smjonas/live-command.nvim",
    cmd = { "G" },
    opts = { commands = { G = { cmd = "g" } } },
  },

  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    version = nil,
    branch = "master",
  },

  -- for 'z' menu
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
    },
  },
}
