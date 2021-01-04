return function(config, on_attach)
    local bin_path = vim.fn.stdpath("cache") .. "/lspconfig/sumneko-lua-language-server/sumneko-lua-language-server"

    config.sumneko_lua.setup {
        on_attach = on_attach,
        cmd = {bin_path},
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = vim.split(package.path, ";")
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {"vim", "use"}
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    }
                }
            }
        }
    }
end
