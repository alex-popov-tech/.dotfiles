return {
  {
    "echasnovski/mini.nvim",
    dependencies = {
      {
        "folke/ts-comments.nvim",
        lazy = true,
        opts = {},
      },
    },
    event = "VeryLazy",
    version = false,
    config = function()
      local extra = require("mini.extra")

      require("mini.basics").setup()
      require("mini.surround").setup()

      require("mini.move").setup({ -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = "H",
          right = "L",
          down = "J",
          up = "K",
          -- Move current line in Normal mode
          line_left = "",
          line_right = "",
          line_down = "",
          line_up = "",
        },
      })

      local gen_ai_spec = extra.gen_ai_spec
      require("mini.ai").setup({
        search_method = "cover_or_nearest",
        -- mappings = {
        --   around_next = "",
        --   inside_next = "",
        --   around_last = "",
        --   inside_last = "",
        -- },
        -- custom_textobjects = {
        --   b = { { "%b()", "%b[]", "%b{}" }, "^.().*().$" },
        --   d = gen_ai_spec.diagnostic(),
        --   l = gen_ai_spec.line(),
        --   n = gen_ai_spec.number(),
        -- },
      })

      require("mini.bufremove").setup({})
      vim.api.nvim_create_user_command("BDelete", function()
        MiniBufremove.delete()
      end, {})
      vim.keymap.set("ca", "bd", "BDelete")
    end,
  },
}
