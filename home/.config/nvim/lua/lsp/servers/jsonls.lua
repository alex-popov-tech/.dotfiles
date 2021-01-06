return function(config, on_attach)
    local bin_path = vim.fn.stdpath("cache") .. "/lspconfig/json-languageserver/vscode-json-languageserver"
    config.jsonls.setup {
        cmd = {bin_path},
        on_attach = on_attach,
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
                end
            }
        }
    }
end
