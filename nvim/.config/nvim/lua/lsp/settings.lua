return function()
    -- define line number hl for lines with Lsp errors
    vim.cmd [[sign define DiagnosticSignWarn text= texthl= numhl=DiagnosticSignWarn linehl=]]
    vim.cmd [[sign define DiagnosticSignError text= texthl= numhl=DiagnosticSignError linehl=]]

    -- set global diagnostic config
    vim.diagnostic.config({
        signs = true,
        underline = true,
        virtual_text = {prefix = '<'},
        float = {scope = 'line', border = 'rounded', focusable = false},
        severity_sort = true
    })

    -- add borders to some floating things
    vim.lsp.handlers['textDocument/hover'] =
        lsp.with(vim.lsp.handlers.hover, {border = 'rounded', focusable = false})
    vim.lsp.handlers['textDocument/signatureHelp'] =
        lsp.with(vim.lsp.handlers.signature_help,
                 {border = 'rounded', focusable = false})

end
