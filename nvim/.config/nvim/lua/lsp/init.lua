local lsp_installer = require("nvim-lsp-installer")

-- local servers = {"efm", "eslintls", "tsserver", "jsonls", "sumneko_lua", "terraformls" }
local servers = {"efm", "tsserver", "jsonls", "sumneko_lua", "terraformls" }
-- local servers = {"efm"}

_G.uninstallLspServers = function()
    cmd('LspUninstallAll')
end
_G.installLspServers = function()
    cmd('LspUninstallAll')
    for _, name in pairs(servers) do
      print("installing " .. name)
      cmd('LspInstall ' .. name)
    end
end

lsp_installer.on_server_ready(function(server)
    -- todo https://github.com/williamboman/nvim-lsp-installer/issues/63
    if not includes(servers, server.name) then
      return
    end

    local configurationFunc = require("lsp.servers." .. server.name)
    local general_on_attach = require("lsp.on_attach")
    local opts = configurationFunc(general_on_attach)

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

require("lsp.commands")()
require("lsp.settings")()
