return function(config, on_attach)
  config.tsserver.setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      -- tsserver, stop messing with prettier da fuck!
      client.resolved_capabilities.document_formatting = false
    end
  }
end
