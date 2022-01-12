return function(on_attach)
    return {
        on_attach = on_attach,
        filetypes = {
            'html',
            'css',
            'javascriptreact',
            'typescriptreact',
            'jsx',
            'tsx'
        }
    }
end
