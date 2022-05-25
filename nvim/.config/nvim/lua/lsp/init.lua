local servers = {'sumneko_lua', 'jsonls', 'tsserver', 'ls_emmet'}
local lsp_installer = require('nvim-lsp-installer')
lsp_installer.setup({
  ensure_installed = servers, -- ensure these servers are always installed
  automatic_installation = true -- automatically detect which servers to install (based on which servers are set up via lspconfig)
})
require('lsp.settings')()
require('lsp.servers.custom_servers')

local general_on_attach = require('lsp.on_attach')

for _, serverName in pairs(servers) do
    local serverConfig =
        require('lsp.servers.' .. serverName)(general_on_attach)

    serverConfig.flags = {debounce_text_changes = 100, lintDebounce = 200}
    serverConfig.capabilities = require('cmp_nvim_lsp').update_capabilities(
                                    vim.lsp.protocol.make_client_capabilities())
    require('lspconfig')[serverName].setup(serverConfig)
    vim.cmd [[ do User LspAttachBuffers ]]
end
