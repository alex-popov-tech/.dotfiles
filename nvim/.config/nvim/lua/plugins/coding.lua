return {

  -- A Neovim plugin that provides the SchemaStore catalog for use with jsonls and yamlls.
  { "b0o/schemastore.nvim" },

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
}
