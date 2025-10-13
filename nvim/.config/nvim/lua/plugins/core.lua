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
    "alex-popov-tech/change_case.nvim",
    init = function()
      vim.o.iskeyword = "@,48-57,_,192-255,-"
    end,
    keys = {
      {
        "gC",
        function()
          require("change_case").coherse_keyword("camel_case")
        end,
      },
      {
        "gs",
        function()
          require("change_case").coherse_keyword("snake_case")
        end,
      },
      {
        "gk",
        function()
          require("change_case").coherse_keyword("kebab_case")
        end,
      },
    },
  },

  {
    "smjonas/live-command.nvim",
    cmd = "Preview",
    config = function()
      require("live-command").setup()
    end,
  },
}
