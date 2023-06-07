return {
    -- diagnostics in separate buffer
    {
        'folke/trouble.nvim',
        cmd = {'TroubleToggle'},
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            require('trouble').setup({
                auto_close = true,
                use_diagnostic_signs = true,
                mode = 'document_diagnostics' -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
            })
        end
    },

    -- code action pretty menu
    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
        keys = {{'\'a', '<cmd>CodeActionMenu<cr>'}}
    },
    -- organize imports for typescript
    {
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        ft = {'typescript', 'typescriptreact'}
    }

}
