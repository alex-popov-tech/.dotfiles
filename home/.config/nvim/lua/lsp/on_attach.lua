local lsp_completion = require("completion")

_G._show_diagnostics = function(opts)
    opts = opts or {}
    vim.lsp.diagnostic.set_loclist({open_loclist = false})
    require "telescope.builtin".loclist(opts)
end

return function(client, bufnr)
    local options = {noremap = true, silent = true}
    if client.resolved_capabilities.completion then
        lsp_completion.on_attach(client, bufnr)
    end
    if client.resolved_capabilities.hover then
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", options)
    end
    if client.resolved_capabilities.find_references then
        map("n", "'re", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", options)
    end
    map("n", "'i", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
    if client.resolved_capabilities.goto_definition then
        map("n", "'d", "<cmd>lua vim.lsp.buf.definition()<CR>", options)
    end
    if client.resolved_capabilities.rename then
        map("n", "'rn", "<cmd>lua vim.lsp.buf.rename()<CR>", options)
    end
    map("n", "'a", "<cmd>lua require'telescope.builtin'.lsp_code_actions()<cr>", options)
    map("n", "'D", "<cmd>lua _show_diagnostics()<CR>", options)
    map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { show_header = false } })<CR>", options)
    map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { show_header = false } })<CR>", options)

    au("CursorMovedI", "*", "lua vim.lsp.buf.signature_help()")
    au("CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })")
    au("bufwritepost", "*", "lua fmt()")
end
