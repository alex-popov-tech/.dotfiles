local lsp_installer = require("nvim-lsp-installer")

local servers = {"efm", "tsserver", "jsonls", "sumneko_lua", "terraformls"}
-- local servers = {"tsserver", "jsonls", "sumneko_lua", "terraformls"}

_G.installLspServers = function()
    cmd("LspUninstallAll")
    local serversString = ""
    for _, name in pairs(servers) do
        serversString = serversString .. " " .. name
    end
    cmd("LspInstall" .. serversString)
end

lsp_installer.on_server_ready(
    function(server)
        -- todo https://github.com/williamboman/nvim-lsp-installer/issues/63
        if not includes(servers, server.name) then
            return
        end

        local general_on_attach = require("lsp.on_attach")

        local serverConfig = require("lsp.servers." .. server.name)(general_on_attach)
        local defaultFlags = {
          debounce_text_changes = 150,
        }
        serverConfig['flags'] = defaultFlags
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
        serverConfig['capabilities'] = capabilities

        server:setup(serverConfig)
        vim.cmd [[ do User LspAttachBuffers ]]

        require("lsp.settings")()
    end
)

