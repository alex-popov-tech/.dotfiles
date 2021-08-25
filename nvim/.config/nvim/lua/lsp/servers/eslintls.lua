return function(general_on_attach)
    return {
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = true
          general_on_attach(client,bufnr)
        end,
        settings = {
            -- run = "onSave",
            format = { enable = true }, -- this will enable formatting
        }
    }
end
