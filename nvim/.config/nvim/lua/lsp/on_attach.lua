return function(client, bufnr)
    local options = {noremap = true, silent = true}

    --  printt(client.config.capabilities.textDocument)
    --  if client.config.capabilities.textDocument.hover then
        map('n', 'K', function() vim.lsp.buf.hover() end, options)
    --  end
    --  if client.config.capabilities.signature_help then
        map('i', '<c-k>', function() vim.lsp.buf.signature_help() end, options)
    --  end
    --  if client.config.capabilities.find_references then
        map('n', '\'gr', function()
            require'telescope.builtin'.lsp_references({
                layout_strategy = 'vertical',
                layout_settings = {width = 0.9, height = 0.9}
            })
        end, options)
    --  end
    --  if client.config.capabilities.goto_definition then
        map('n', '\'gd', function() vim.lsp.buf.definition() end, options)
    --  end
    --  if client.config.capabilities.rename then
        map('n', '\'rn', function() vim.lsp.buf.rename() end, options)
        --  map('n', '\'rn', function() vim.lsp.buf.rename.float() end, options)
    --  end

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
        --  if client.supports_method('textDocument/formatting') then
            vim.lsp.buf.formatting_sync()
        --  end
    end, options)
end
