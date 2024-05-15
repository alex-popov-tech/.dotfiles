return {

  -- A Neovim plugin that provides the SchemaStore catalog for use with jsonls and yamlls.
  { "b0o/schemastore.nvim" },

  -- current lsp path in winbar
  { "SmiteshP/nvim-navic", dependencies = { "neovim/nvim-lspconfig" } },

  -- screen code snippets
  {
    "mistricky/codesnap.nvim",
    event = "VeryLazy",
    build = "make",
    config = function()
      local codesnap = require("codesnap")
      for _, name in ipairs({ "Screen", "Take", "TakeScreen" }) do
        vim.api.nvim_create_user_command(name, function()
          codesnap.copy_into_clipboard()
        end, { nargs = "*", range = "%" })
      end
    end,
  },

  -- visual representation for idention
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPre",
    opts = {
      indent = { char = "│" },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
        },
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    keys = { { "<leader>cc" }, { "<leader>c", mode = { "x", "o" } } },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        toggler = { line = "<leader>cc" },
        opleader = { line = "<leader>c" },
        pre_hook = function(ctx)
          -- Only calculate commentstring for tsx filetypes
          if vim.bo.filetype == "typescriptreact" then
            local U = require("Comment.utils")

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
              location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring({
              key = type,
              location = location,
            })
          end
        end,
      })
    end,
  },
}
