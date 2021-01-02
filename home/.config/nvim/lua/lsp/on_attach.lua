local lsp_completion = require("completion")

return function(client, bufnr)
    if client.resolved_capabilities.completion then
        lsp_completion.on_attach(client, bufnr)
    -- map("i", "<c-n>", "<Plug>(completion_trigger)", false)
    -- map("i", "<c-j>", "<Plug>(completion_next_source)", false)
    -- map("i", "<c-k>", "<Plug>(completion_prev_source)", false)
    end
    local mappingOptions = {noremap = true, silent = true}
    if client.resolved_capabilities.hover then
        vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", mappingOptions)
    end
    if client.resolved_capabilities.find_references then
        vim.api.nvim_set_keymap("n", "'re", "<cmd>lua vim.lsp.buf.references()<CR>", mappingOptions)
    end
    if client.resolved_capabilities.rename then
        vim.api.nvim_set_keymap("n", "'rn", "<cmd>lua vim.lsp.buf.rename()<CR>", mappingOptions)
    end
    vim.api.nvim_set_keymap("i", "<tab>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", mappingOptions)
    vim.api.nvim_set_keymap("n", "'i", "<cmd>Implementations<CR>", mappingOptions)
    vim.api.nvim_set_keymap("n", "'a", "<cmd>CodeActions<cr>", mappingOptions)
    vim.api.nvim_set_keymap(
        "n",
        "[d",
        "<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { show_header = false } })<CR>",
        mappingOptions
    )
    vim.api.nvim_set_keymap(
        "n",
        "]d",
        "<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { show_header = false } })<CR>",
        mappingOptions
    )
    vim.api.nvim_set_keymap("n", "'d", "<cmd>Diagnostics<CR>", mappingOptions)

    vim.api.nvim_command("setlocal omnifunc=lua.vim.lsp.omnifunc")
    vim.api.nvim_command("autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })")
end
