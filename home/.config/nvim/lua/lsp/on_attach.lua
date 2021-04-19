function _FMT()
    if ft() == "json" then
        vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
        return
    end

    if ft() == "typescript" then
        require "nvim-lsp-ts-utils".organize_imports_sync()
    end

    vim.lsp.buf.formatting_sync(nil, 800)
end

return function(client, bufnr)
    local options = {noremap = true, silent = true}
    if client.resolved_capabilities.hover then
        map("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", options)
    end
    if client.resolved_capabilities.find_references then
        map("n", "'re", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", options)
    end
    if client.resolved_capabilities.goto_definition then
        map("n", "'d", "<cmd>lua vim.lsp.buf.definition()<CR>", options)
    end
    if client.resolved_capabilities.rename then
        map("n", "'rn", "<cmd>lua require'lspsaga.rename'.rename()<CR>", options)
    end

    map("n", "'i", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
    map("n", "'a", "<cmd>lua require'lspsaga.codeaction'.code_action()<CR>", options)
    map("v", "'a", "<cmd>lua require'lspsaga.codeaction'.range_code_action()<CR>", options)

    au("cursorhold", "*", 'lua require "lspsaga.diagnostic".show_line_diagnostics()')
    require "timer".add(
        function()
            if not require("lspsaga.signaturehelp").has_saga_signature() and vim.fn.mode() == "i" then
                require("lspsaga.signaturehelp").signature_help()
            end
            return 1000
        end
    )

    map("n", "[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", options)
    map("n", "]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", options)

    au("bufwritepost", "*", "lua _FMT()")
end
