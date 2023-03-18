return function(client, bufnr)
    local options = {noremap = true, silent = true}

    vim.keymap.set('n', 'K', function()
        if not pcall(require, 'ufo') then
            vim.lsp.buf.hover()
        end

        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end, options)
    vim.keymap.set('i', '<c-k>', function() vim.lsp.buf.signature_help() end, options)
    vim.keymap.set('n', '\'gr', function()
        require'telescope.builtin'.lsp_references({
            layout_strategy = 'vertical',
            layout_settings = {width = 0.9, height = 0.9}
        })
    end, options)
    vim.keymap.set('n', '\'gd', function() vim.lsp.buf.definition() end, options)

    vim.keymap.set('n', '\'rn', function() vim.lsp.buf.rename() end, options)

    vim.keymap.set('n', '[d',
        function() vim.diagnostic.goto_prev({float = {border = 'single'}}) end,
        options)
        vim.keymap.set('n', ']d',
        function() vim.diagnostic.goto_next({float = {border = 'single'}}) end,
        options)
        vim.keymap.set('n', '\'gi', function() vim.lsp.buf.implementation() end, options)
        vim.keymap.set('n', '\'a', '<cmd>CodeActionMenu<CR>', options)
        vim.keymap.set('n', '\'d', function()
        vim.diagnostic.open_float(0, {
            scope = 'line',
            source = 'if_many',
            border = 'rounded',
            focusable = false
        })
    end, options)
    vim.keymap.set('n', '\'D', '<cmd>TroubleToggle<CR>', options)

    vim.keymap.set('n', '<leader>f', function()
        -- if vim.bo.filetype == 'typescript' then
        --   require 'nvim-lsp-ts-utils'.organize_imports_sync()
        -- end
        vim.lsp.buf.format({
            async = false,
            filter = function(filterClient)
                return filterClient.name == 'null-ls'
            end
        })
    end, options)
end
