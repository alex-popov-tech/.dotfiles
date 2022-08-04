local M = {}

M.servers = {'sumneko_lua', 'jsonls', 'tsserver', 'cssls'}

M.setup = function()
    require('lsp.settings')()
    local general_on_attach = require('lsp.on_attach')

    for _, serverName in pairs(M.servers) do
        local serverConfig = require('lsp.servers.' .. serverName)(
                                 general_on_attach)

        serverConfig.flags = {debounce_text_changes = 100, lintDebounce = 200}
        serverConfig.capabilities = require('cmp_nvim_lsp').update_capabilities(
                                        vim.lsp.protocol
                                            .make_client_capabilities())
        require('lspconfig')[serverName].setup(serverConfig)
    end

    local null_ls = require('null-ls')
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
        sources = {
            formatting.prettierd,
            formatting.fixjson,
            formatting.lua_format,
            diagnostics.eslint_d.with({timeout = 10000}),
            diagnostics.yamllint,
            diagnostics.markdownlint,
            diagnostics.proselint.with({extra_filetypes = {'markdown'}}),
            diagnostics.cspell.with({
                extra_filetypes = {'typescript', 'octo'},
                diagnostics_postprocess = function(diagnostic)
                    diagnostic.severity = vim.diagnostic.severity['WARN']
                end
            }),
            code_actions.eslint_d,
            code_actions.proselint
        },
        on_attach = general_on_attach
    })
end

return M
