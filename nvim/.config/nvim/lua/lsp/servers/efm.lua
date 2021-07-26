return function(config, on_attach)
    local prettier_pug = {
        formatCommand = "prettier --tab-width 4 --stdin-filepath ${INPUT}",
        formatStdin = true
    }
    local prettier_sh = {
        formatCommand = "prettier --tab-width 4 --stdin-filepath ${INPUT}",
        formatStdin = true
    }
    local yaml = {
        lintCommand = "yamllint -f parsable -",
        lintStdin = true,
        formatCommand = "prettier --tab-width 4 --stdin-filepath ${INPUT}",
        formatStdin = true
    }
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
    local filetypeConfigMap = {
        typescript = {eslint_d},
        javascript = {eslint_d},
        typescriptreact = {eslint_d},
        javascriptreact = {eslint_d},
        lua = {luaFormat},
        sh = {prettier_sh},
        zsh = {prettier_sh},
        pug = {prettier_pug},
        yaml = {yaml}
    }
    config.efm.setup {
        init_options = {
            documentFormatting = true,
            codeAction = true
        },
        settings = {
            languages = filetypeConfigMap
        },
        filetypes = keys(filetypeConfigMap),
        on_attach = on_attach
    }
end
