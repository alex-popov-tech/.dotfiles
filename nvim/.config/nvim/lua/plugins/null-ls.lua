return function()
    require("null-ls").setup(
        {
            sources = {
                require("null-ls").builtins.diagnostics.eslint_d.with({ timeout = 10000 }),
                require("null-ls").builtins.formatting.prettier
            }
        }
    )
    -- local general_on_attach = require("lsp.on_attach")
    -- require("lspconfig")["null-ls"].setup({
    --   on_attach = general_on_attach
    -- })
end
