return function(config, on_attach)
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    return {
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = runtime_path
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {"vim", "use"}
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        library = vim.api.nvim_get_runtime_file("", true)
                    }
                },
                telemetry = {
                    enable = false
                }
            }
        }
    }
end
