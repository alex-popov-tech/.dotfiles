local general_on_attach = require('lsp.on_attach')

local M = {}

M.servers = { 'sumneko_lua', 'jsonls', 'tsserver', 'cssls', 'gopls' }

M.setup = function()
  require('lsp.settings')()
  require('lsp.servers.nullls').setup()

  for _, serverName in pairs(M.servers) do
    local serverConfig = require('lsp.servers.' .. serverName)(
      general_on_attach)

    serverConfig.flags = { debounce_text_changes = 100, lintDebounce = 200 }
    serverConfig.capabilities = serverConfig.capabilities or require('cmp_nvim_lsp').default_capabilities()

    require('lspconfig')[serverName].setup(serverConfig)
  end

end

return M
