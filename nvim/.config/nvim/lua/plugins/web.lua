return {

  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "html", "css", "javascriptreact", "typescriptreact", "templ" },
    build = ":UpdateRemotePlugins",
    dependencies = { { "nvim-treesitter/nvim-treesitter", lazy = true } },
    enabled = false, -- throws errors
    opts = {
      document_color = {
        enabled = false,
      },
      conceal = {
        enabled = true, -- can be toggled by commands
        symbol = "󱏿", -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = "#38BDF8",
        },
      },
    },
  },
}
