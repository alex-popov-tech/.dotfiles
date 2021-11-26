return function(client, bufnr)
    local options = {noremap = true, silent = true}

    if client.resolved_capabilities.hover then
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", options)
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
        map("n", "'rn", "<cmd>lua vim.lsp.buf.rename.float()<cr>", options)
    end

    map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ float =  { border = 'single' }})<CR>", options)
    map("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ float =  { border = 'single' }})<CR>", options)
    map("n", "'gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
    map("n", "'a", "<cmd>CodeActionMenu<CR>", options)
    map("n", "'d", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single", focusable = true })<CR>', options)
    map("n", "'D", "<cmd>TroubleToggle<CR>", options)

    map("n", "<leader>f", "<cmd>lua fmt()<CR>", options)
end
