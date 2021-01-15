local lsp_completion = require("completion")

return function(client, bufnr)
    lsp_completion.on_attach(client, bufnr)
    local mappingOptions = {noremap = true, silent = true}
    vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", mappingOptions)
    vim.api.nvim_set_keymap("n", "'re", "<cmd>lua vim.lsp.buf.references()<CR>", mappingOptions)
    vim.api.nvim_set_keymap("n", "'i", "<cmd>Implementations<CR>", mappingOptions)
    vim.api.nvim_set_keymap("n", "'d", "<cmd>Definitions<CR>", mappingOptions)
    vim.api.nvim_set_keymap("n", "'rn", "<cmd>lua vim.lsp.buf.rename()<CR>", mappingOptions)
    vim.api.nvim_set_keymap("i", "<s-tab>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", mappingOptions)
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
    vim.api.nvim_set_keymap("n", "'D", "<cmd>Diagnostics<CR>", mappingOptions)

    vim.api.nvim_command("autocmd CursorMovedI * lua vim.lsp.buf.signature_help()")
    vim.api.nvim_command("autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })")
end
