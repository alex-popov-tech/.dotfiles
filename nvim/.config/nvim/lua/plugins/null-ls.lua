return function()
    require("null-ls").setup(
        {
            sources = {
                require("null-ls").builtins.diagnostics.eslint_d.with({ timeout = 10000 }),
                require("null-ls").builtins.formatting.prettierd
            }
        }
    )
end
