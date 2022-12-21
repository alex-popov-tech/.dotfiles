local M = {}

M.list = {
    'eslint_d',
    'prettierd',
    'xo',
    'cspell',
    'proselint',
    'yamllint',
    'golangci-lint',
    'goimports',
    'goimports',
    'delve',
    'selene',
    'luaformatter'
}

M.setup = function()
    local general_on_attach = require('lsp.on_attach')
    local null_ls = require('null-ls')
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    local code_actions = null_ls.builtins.code_actions

    local root_has_file = function(names)
        return function(utils) return utils.root_has_file(names) end
    end

    null_ls.setup({
        debounce = 100,
        update_in_insert = false,
        sources = {
            formatting.prettierd,
            formatting.fixjson,
            formatting.gofmt,
            formatting.goimports,
            formatting.lua_format,

            diagnostics.selene,
            diagnostics.eslint_d.with({timeout = 10000}),
            diagnostics.yamllint,
            diagnostics.proselint.with({extra_filetypes = {'markdown', 'octo'}}),
            diagnostics.cspell.with({
                extra_filetypes = {'octo'},
                diagnostics_postprocess = function(diagnostic)
                    diagnostic.severity = vim.diagnostic.severity['WARN']
                end
            }),
            diagnostics.golangci_lint,

            code_actions.gitsigns
        },
        on_attach = function(client, bufnr)
            general_on_attach(client, bufnr)
            local lsp_format_modifications = require('lsp-format-modifications')
            lsp_format_modifications.attach(client, bufnr,
                                            {format_on_save = false})
        end
    })
end

return M
