local lsp_config = require("lspconfig")
local general_on_attach = require("lsp.on_attach")

for _, server in pairs({"vimls", "jsonls", "bashls", "tsserver", "sumneko_lua", "efm"}) do
  require("lsp.servers." .. server)(lsp_config, general_on_attach)
end

require("lsp.commands")()
require("lsp.settings")()
