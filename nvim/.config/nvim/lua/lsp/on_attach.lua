return function(client, bufnr)
    local options = {noremap = true, silent = true}

    map('n', 'K', function() vim.lsp.buf.hover() end, options)
    map('i', '<c-k>', function() vim.lsp.buf.signature_help() end, options)
    map('n', '\'gr', function()
        require'telescope.builtin'.lsp_references({
            layout_strategy = 'vertical',
            layout_settings = {width = 0.9, height = 0.9}
        })
    end, options)
    map('n', '\'gd', function() vim.lsp.buf.definition() end, options)
    vim.api.nvim_set_keymap('n', '\'rn', ':Rename ', {})

    map('n', '[d',
        function() vim.diagnostic.goto_prev({float = {border = 'single'}}) end,
        options)
    map('n', ']d',
        function() vim.diagnostic.goto_next({float = {border = 'single'}}) end,
        options)
    map('n', '\'gi', function() vim.lsp.buf.implementation() end, options)
    map('n', '\'a', '<cmd>CodeActionMenu<CR>', options)
    map('n', '\'d', function()
        vim.diagnostic.open_float(0, {
            scope = 'line',
            border = 'rounded',
            focusable = false
        })
    end, options)
    map('n', '\'D', '<cmd>TroubleToggle<CR>', options)

    map('n', '<leader>f', function()
        if ft() == 'typescript' then
            require'nvim-lsp-ts-utils'.organize_imports_sync()
        end
        vim.lsp.buf.format({async = true})
    end, options)
end
