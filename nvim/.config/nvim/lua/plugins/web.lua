return {

  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "html", "css", "javascriptreact", "typescriptreact", "templ" },
    dependencies = { { "nvim-treesitter/nvim-treesitter", lazy = true } },
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

  -- autocomplete closing tags, auto rename
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "templ",
      "astro",
      "glimmer",
      "handlebars",
      "html",
      "jsx",
      "markdown",
      "php",
      "rescript",
      "svelte",
      "tsx",
      "twig",
      "vue",
      "xml",
    },
    opts = {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
    },
  },
}
