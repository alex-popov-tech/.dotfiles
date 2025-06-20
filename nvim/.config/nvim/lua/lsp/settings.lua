return function(client)
  -- Enable inlay hints
  -- vim.lsp.inlay_hint.enable(true)
        vim.diagnostic.config({ signs = function() end })
end
