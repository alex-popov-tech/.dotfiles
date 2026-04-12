return {
  settings = {
    yaml = {
      -- disable built-in schemaStore so schemastore.nvim can provide schemas
      -- via vim.lsp.config('yamlls', ...) in plugin/lsp.lua
      schemaStore = {
        enable = false,
        url = "",
      },
    },
  },
}
