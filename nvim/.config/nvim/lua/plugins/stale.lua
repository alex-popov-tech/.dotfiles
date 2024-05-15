return {
  {
    "Wansmer/treesj",
    enable = false,
    keys = { {
      "<leader>s",
      function()
        require("treesj").toggle()
      end,
      mode = { "n" },
    } },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false },
  },
}
