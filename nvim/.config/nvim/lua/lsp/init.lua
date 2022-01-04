require("lsp.settings")()
local lsp_installer = require("nvim-lsp-installer")

local servers = { "sumneko_lua", "jsonls", "tsserver" }

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
        local general_on_attach = require("lsp.on_attach")

        local serverConfig = require("lsp.servers." .. server.name)(general_on_attach)

        serverConfig.flags = {debounce_text_changes = 100, lintDebounce = 200}
        serverConfig.capabilities =
            require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

        server:setup(serverConfig)
        vim.cmd [[ do User LspAttachBuffers ]]

    end
)
