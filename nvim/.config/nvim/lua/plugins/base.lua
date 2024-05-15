return {
  --  shiftwidth/expandtab/etc
  -- {'tpope/vim-sleuth', event = 'VeryLazy'},

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
}
