return function(config, on_attach)
    local util = require "lspconfig/util"
    local bin_path = vim.fn.stdpath("cache") .. "/lspconfig/typescript-language-server/typescript-language-server"
    config.tsserver.setup {
        cmd = {bin_path, "--stdio"},
        filetypes = {"typescript","javascript"},
        root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git", vim.fn.getcwd()),
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- tsserver, stop messing with prettier da fuck!
            client.resolved_capabilities.document_formatting = false
        end
    }
end
