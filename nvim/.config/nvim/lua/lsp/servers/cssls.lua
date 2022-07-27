return function(on_attach)
    return {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- tsserver, stop messing with prettier da fuck!
            client.server_capabilities.documentFormattingProvider = false
        end,
        settings = {}
    }
end
