return function()
  local lsp = require('lsp')
  require('mason').setup()
  require('mason-lspconfig').setup({
    automatic_installation = true,
    ensure_installed = lsp.servers
  })
end
