return function()
    require("trouble").setup(
        {
            auto_close = true,
            use_diagnostic_signs = true,
            mode = "document_diagnostics" -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
        }
    )
end
