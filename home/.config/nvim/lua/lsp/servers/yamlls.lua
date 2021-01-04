return function(config, on_attach)
    local util = require "lspconfig/util"
    local bin_path = vim.fn.stdpath("cache") .. "/lspconfig/yaml-language-server/yaml-language-server"
    config.yamlls.setup {
        cmd = {bin_path, "--stdio"},
        filetypes = {"yaml"},
        root_dir = util.root_pattern(".git", vim.fn.getcwd()),
        on_attach = on_attach
    }
end
