return function(client, bufnr)
    local options = {noremap = true, silent = true}

    if client.resolved_capabilities.hover then
        map("n", "K", function() vim.lsp.buf.hover() end, options)
    end
    if client.resolved_capabilities.signature_help then
        map("i", "<c-k>", function() vim.lsp.buf.signature_help() end, options)
    end
    if client.resolved_capabilities.find_references then
        map(
            "n",
            "'gr",
            function() require'telescope.builtin'.lsp_references({layout_strategy='vertical',layout_config={width=0.9, height=0.9}}) end,
            options
        )
    end
    if client.resolved_capabilities.goto_definition then
        map("n", "'gd", function() vim.lsp.buf.definition() end, options)
    end
    if client.resolved_capabilities.rename then
        map("n", "'rn", function() vim.lsp.buf.rename.float() end, options)
    end

    map("n", "[d", function() vim.diagnostic.goto_prev({ float =  { border = 'single' }}) end, options)
    map("n", "]d", function() vim.diagnostic.goto_next({ float =  { border = 'single' }}) end, options)
    map("n", "'gi", function() vim.lsp.buf.implementation() end, options)
    map("n", "'a", "<cmd>CodeActionMenu<CR>", options)
    map("n", "'d", function() vim.diagnostic.open_float(0, { scope = "line", border = "rounded", focusable = false }) end, options)
    map("n", "'D", "<cmd>TroubleToggle<CR>", options)

    map("n", "<leader>f", function() fmt() end, options)
end
