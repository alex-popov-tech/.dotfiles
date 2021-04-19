local general_on_attach = require("lsp.on_attach")
require "lspinstall".setup()

local servers = {"efm", "json", "lua", "typescript", }

_G.installLspServers = function()
    local existingServers = require "lspinstall".installed_servers()
    for _, name in pairs(existingServers) do
        require "lspinstall".uninstall_server(name)
    end

    for _, name in pairs(servers) do
        require "lspinstall".install_server(name)
    end
end

for _, server in pairs(servers) do
    require("lsp.servers." .. server)(require'lspconfig', general_on_attach)
end

require("lsp.commands")()
require("lsp.settings")()
