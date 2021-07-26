require "lspinstall".setup()

local servers = {"efm", "json", "lua", "typescript", "terraform"}

_G.uninstallLspServers = function()
    local existingServers = require "lspinstall".installed_servers()
    for _, name in pairs(existingServers) do
      cmd('LspUninstall ' .. name)
    end
end
_G.installLspServers = function()
    for _, name in pairs(servers) do
      cmd('LspInstall ' .. name)
    end
end

for _, server in pairs(servers) do
  local configurationFunc = require("lsp.servers." .. server)
  local initialConfig = require'lspconfig'
  local general_on_attach = require("lsp.on_attach")
  configurationFunc(initialConfig, general_on_attach)
end

require("lsp.commands")()
require("lsp.settings")()
