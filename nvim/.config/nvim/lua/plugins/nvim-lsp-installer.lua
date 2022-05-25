return function()
    require('nvim-lsp-installer').setup({
        ensure_installed = {'sumneko_lua', 'jsonls', 'tsserver', 'ls_emmet'}, -- ensure these servers are always installed
        automatic_installation = true -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    })
end
