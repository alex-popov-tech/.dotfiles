return function(on_attach)
    return {
        -- filetypes = {"typescript", "javascript"},
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- tsserver, stop messing with prettier da fuck!
            client.server_capabilities.documentFormattingProvider = false
            require("nvim-lsp-ts-utils").setup {}
        end
    }
end
