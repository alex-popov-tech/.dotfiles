
return function(client, bufnr)


    local options = {noremap = true, silent = true}

    if client.resolved_capabilities.hover then
        map("n", "K", "<cmd>Lspsaga hover_doc<CR>", options)
    end
    if client.resolved_capabilities.find_references then
        map(
            "n",
            "'gr",
            "<cmd>lua require'telescope.builtin'.lsp_references({layout_strategy='vertical',layout_config={width=0.9, height=0.9}})<CR>",
            options
        )
    end
    if client.resolved_capabilities.goto_definition then
        map("n", "'gd", "<cmd>lua vim.lsp.buf.definition()<CR>", options)
    end
    if client.resolved_capabilities.rename then
        map("n", "'rn", "<cmd>Lspsaga rename<cr>", options)
    end

    au("cursorholdi", "*", "Lspsaga signature_help")

    map("n", ".d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", options)
    map("n", ",d", "<cmd>lua vim.diagnostic.goto_next()<cr>", options)
    map("n", "'i", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
    map("n", "'a", "<cmd>CodeActionMenu<CR>", options)
    map("n", "'d", '<cmd>lua vim.diagnostic.show_line_diagnostics({ show_header = false })<CR>', options)
    map("n", "'D", '<cmd>TroubleToggle<CR>', options)

    map("n", "<leader>f", "<cmd>lua fmt()<CR>", options)
end
