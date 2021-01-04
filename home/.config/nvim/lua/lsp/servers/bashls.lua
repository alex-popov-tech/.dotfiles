return function(config, on_attach)
    local util = require "lspconfig/util"
    local bin_path = vim.fn.stdpath("cache") .. "/lspconfig/bash-language-server/bash-language-server"
    config.bashls.setup {
        cmd = {bin_path, "start"},
        filetypes = {"sh"},
        root_dir = util.root_pattern(".git", vim.fn.getcwd()),
        on_attach = on_attach,
    }
end
