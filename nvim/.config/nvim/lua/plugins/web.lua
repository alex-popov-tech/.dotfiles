return {

  {
    "luckasRanarison/tailwind-tools.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      conceal = {
        enabled = true, -- can be toggled by commands
        symbol = "󱏿", -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = "#38BDF8",
        },
      },
    },
  },

  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
        opts = {
          rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
        },
      },
    },
  },

  -- autocomplete closing tags, auto rename
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
