require("lsp.settings")()
local lsp_installer = require("nvim-lsp-installer")
require("lsp.servers.customs")
local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

local general_on_attach = require("lsp.on_attach")
local servers = {"sumneko_lua", "jsonls", "tsserver", "ls_emmet"}

_G.installLspServers = function()
    cmd("LspUninstallAll")
    local serversString = ""
    for _, name in pairs(servers) do
        serversString = serversString .. " " .. name
    end
    cmd("LspInstall" .. serversString)
end

lsp_installer.on_server_ready(function(server)
    local serverConfig = require("lsp.servers." .. server.name)(
                             general_on_attach)

    serverConfig.flags = {debounce_text_changes = 100, lintDebounce = 200}
    serverConfig.capabilities = require("cmp_nvim_lsp").update_capabilities(
                                    vim.lsp.protocol.make_client_capabilities())
    server:setup(serverConfig)
    vim.cmd [[ do User LspAttachBuffers ]]

end)

null_ls.setup({
    sources = {
        formatting.prettierd,
        formatting.codespell,
        formatting.fixjson,
        formatting.lua_format,
        diagnostics.eslint_d.with({timeout = 5000}),
        diagnostics.codespell,
        diagnostics.yamllint,
        diagnostics.write_good.with({
          extra_filetypes = { "gitcommit" },
        }),
        diagnostics.markdownlint,
        diagnostics.proselint.with({
          extra_filetypes = { "gitcommit", "markdown" },
        }),
        code_actions.eslint_d,
        code_actions.proselint,
    },
    on_attach = general_on_attach
})
