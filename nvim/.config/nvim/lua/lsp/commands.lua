return function()
    -- setup errors ui
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            -- underline = true,
            virtual_text = {
                prefix = "<"
            },
            -- signs = true,
            update_in_insert = false,
            severity_sort = true
        }
    )
    -- write only if diffs there
    vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
        if err ~= nil or result == nil then
            return
        end
        if not vim.api.nvim_buf_get_option(bufnr, "modified") then
            local view = vim.fn.winsaveview()
            vim.lsp.util.apply_text_edits(result, bufnr)
            vim.fn.winrestview(view)
            if bufnr == vim.api.nvim_get_current_buf() then
              vim.cmd [[noautocmd :update]]
            end
        end
    end
end
