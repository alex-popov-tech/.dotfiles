return function(config, on_attach)
  config.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  },
  settings = {
    Lua = {
      runtime = {version = "LuaJIT"},
      diagnostics = {globals = {"vim", "use"}},
      workspace = {
        library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true}
      }
    }
  }
}
end
