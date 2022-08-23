return function(on_attach)

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
  capabilities.textDocument.completion.completionItem.snippetSupport = true


  return {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("lsp-inlayhints").on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true
        },
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
    init_options = {
      usePlaceholders = true,
    }
  }
end
