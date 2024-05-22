return {
  {
    "echasnovski/mini.nvim",
    dependencies = {
      -- {
      --   "JoosepAlviste/nvim-ts-context-commentstring",
      --   opts = { enable_autocmd = false },
      -- },
      {
        "folke/ts-comments.nvim",
        opts = {},
      },
    },
    event = "VeryLazy",
    version = false,
    config = function()
      local extra = require("mini.extra")

      require("mini.basics").setup()

      require("mini.indentscope").setup()

      -- require("mini.files").setup({
      --   windows = {
      --     preview = true,
      --   },
      -- })

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
        mappings = {
          around_next = "",
          inside_next = "",
          around_last = "",
          inside_last = "",
        },
        custom_textobjects = {
          b = { { "%b()", "%b[]", "%b{}" }, "^.().*().$" },
          d = gen_ai_spec.diagnostic(),
          l = gen_ai_spec.line(),
          n = gen_ai_spec.number(),
        },
      })

      require("mini.comment").setup({
        mappings = {
          comment = "<leader>c",
          comment_line = "<leader>cc",
          comment_visual = "<leader>c",
          textobject = "ac",
        },
      })
      -- options =
      --   {
      --     custom_commentstring = function()
      --       return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
      --     end,
      --   },

      require("mini.bufremove").setup({})
      vim.api.nvim_create_user_command("BDelete", function()
        MiniBufremove.delete()
      end, {})
      vim.cmd("cnoreabbrev bd BDelete")
    end,
  },
}
