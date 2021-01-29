return function(config)
    local util = require "lspconfig/util"
    local eslint_d = {
        lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
        lintStdin = true,
        lintFormats = {"%f:%l:%c: %m"},
        lintIgnoreExitCode = true,
        formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
        formatStdin = true
    }
    local luaFormat = {
        formatCommand = "luafmt --stdin",
        formatStdin = true
    }
    local languages = {
        typescript = {eslint_d},
        javascript = {eslint_d},
        typescriptreact = {eslint_d},
        javascriptreact = {eslint_d},
        lua = {luaFormat}
    }
    local bin_path = vim.fn.stdpath("cache") .. "/lspconfig/efm-langserver/efm-langserver"
    config.efm.setup {
        default_config = {
            cmd = bin_path
        },
        root_dir = util.root_pattern(".git", vim.fn.getcwd()),
        init_options = {
            documentFormatting = true,
            codeAction = true
        },
        settings = {
            languages = languages
        },
        filetypes = {
            "javascript",
            "typescript",
            "typescriptreact",
            "javascriptreact",
            "lua"
        }
    }
end
