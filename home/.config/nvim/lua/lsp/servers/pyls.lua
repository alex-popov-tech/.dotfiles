return function(config, on_attach)
    local util = require "lspconfig/util"
    local bin_path = vim.fn.stdpath("cache") .. "/lspconfig/pyls/pyls"
    config.pyls.setup {
        cmd = {bin_path},
        filetypes = {"python"},
        root_dir = util.root_pattern(".git", vim.fn.getcwd()),
        on_attach = on_attach
    }
end
