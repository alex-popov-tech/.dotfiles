return function(config)
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
    local yaml = {
        lintCommand = "yamllint -f parsable -",
        lintStdin = true
    }
    local languages = {
        typescript = {eslint_d},
        javascript = {eslint_d},
        typescriptreact = {eslint_d},
        javascriptreact = {eslint_d},
        lua = {luaFormat},
        yaml = {yaml}
    }
    config.efm.setup {
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
            "lua",
            "yaml"
        }
    }
end
