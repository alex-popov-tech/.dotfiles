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

  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    version = nil,
    branch = "master",
  },

  {
    "smjonas/live-command.nvim", -- live command
    cmd = { "Norm" },
    config = function()
      require("live-command").setup({ commands = { Norm = { cmd = "norm" } } })
    end,
  },
  { "mbbill/undotree", keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>" } }, cmd = "UndotreeToggle" }, -- see undo tree
}
