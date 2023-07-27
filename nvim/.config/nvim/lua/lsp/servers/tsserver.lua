local util = require('util')
local common = require('lsp.servers.common')
return function(on_attach)
    return util.t.merge('force', common, {
        -- filetypes = {"typescript", "javascript"},
        -- settings = {
        --     typescript = {
        --         inlayHints = {
        --             includeInlayParameterNameHints = 'all',
        --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --             includeInlayFunctionParameterTypeHints = true,
        --             includeInlayVariableTypeHints = true,
        --             includeInlayPropertyDeclarationTypeHints = true,
        --             includeInlayFunctionLikeReturnTypeHints = true,
        --             includeInlayEnumMemberValueHints = true
        --         }
        --     },
        --     javascript = {
        --         inlayHints = {
        --             includeInlayParameterNameHints = 'all',
        --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --             includeInlayFunctionParameterTypeHints = true,
        --             includeInlayVariableTypeHints = true,
        --             includeInlayPropertyDeclarationTypeHints = true,
        --             includeInlayFunctionLikeReturnTypeHints = true,
        --             includeInlayEnumMemberValueHints = true
        --         }
        --     }
        -- },
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- tsserver, stop messing with prettier da fuck!
            client.server_capabilities.documentFormattingProvider = false
            require('nvim-lsp-ts-utils').setup {}
        end
    })
end
