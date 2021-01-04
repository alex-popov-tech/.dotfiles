local lsp_completion = require("completion")

return function(client, bufnr)
    lsp_completion.on_attach(client, bufnr)
    -- map("i", "<c-n>", "<Plug>(completion_trigger)", false)
    -- map("i", "<c-j>", "<Plug>(completion_next_source)", false)
    -- map("i", "<c-k>", "<Plug>(completion_prev_source)", false)
    local mappingOptions = {noremap = true, silent = true}
    vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", mappingOptions)
    vim.api.nvim_set_keymap("n", "'re", "<cmd>lua vim.lsp.buf.references()<CR>", mappingOptions)
    vim.api.nvim_set_keymap("n", "'rn", "<cmd>lua vim.lsp.buf.rename()<CR>", mappingOptions)
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

    -- vim.api.nvim_command("setlocal omnifunc=lua.vim.lsp.omnifunc")
    -- vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.api.nvim_command("autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })")
end
