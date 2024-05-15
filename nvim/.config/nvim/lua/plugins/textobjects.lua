return {
  {
    "Julian/vim-textobj-variable-segment",
    keys = { { "av", mode = { "x", "o" } }, { "iv", mode = { "x", "o" } } },
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    keys = {
      { "af", mode = { "x", "o" } },
      { "if", mode = { "x", "o" } },
      { "]m" },
      { "[m" },
      { "]M" },
      { "[M" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = { ["]m"] = "@function.outer" },
          goto_next_end = { ["]M"] = "@function.outer" },
          goto_previous_start = { ["[m"] = "@function.outer" },
          goto_previous_end = { ["[M"] = "@function.outer" },
        },
      },
    },
  },
}
