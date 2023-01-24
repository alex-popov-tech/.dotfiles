local util = require('util')
local general_on_attach = require('lsp.on_attach')
require('lsp.settings')
local lsp_servers = {'sumneko_lua', 'tsserver'}
local tools = {'eslint_d', 'prettierd', 'selene', 'luaformatter'}

return {
    -- automatic install of lsp servers & setup them
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            {
                'folke/neodev.nvim',
                config = function() require('neodev').setup({}) end
            },
            'mason.nvim',
            'williamboman/mason-lspconfig.nvim'
        },
        config = function()
            -- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -- auto install lsp servers
            require('mason-lspconfig').setup({ensure_installed = lsp_servers})

            -- require('neodev').setup({})
            -- setup servers
            require('mason-lspconfig').setup_handlers({
                function(server_name)

                    local opts = require('lsp.servers.' .. server_name)(
                                     general_on_attach)

                    opts.flags = {
                        debounce_text_changes = 100,
                        lintDebounce = 200
                    }
                    opts.capabilities = opts.capabilities or capabilities

                    require('lspconfig')[server_name].setup(opts)
                end
            })
        end
    },

    -- formatters & linters
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufReadPre',
        dependencies = {'mason.nvim'},
        config = function()
            local null_ls = require('null-ls')
            local diagnostics = null_ls.builtins.diagnostics
            local formatting = null_ls.builtins.formatting
            local code_actions = null_ls.builtins.code_actions

            null_ls.setup({
                debug = false,
                debounce = 150,
                update_in_insert = false,
                sources = {
                    formatting.prettierd,
                    formatting.lua_format,
                    formatting.yamlfmt,

                    diagnostics.selene,
                    diagnostics.eslint_d.with({timeout = 10000}),

                    code_actions.gitsigns
                }
            })
        end
    },

    -- main 'mason' & automatic install of tools
    {

        'williamboman/mason.nvim',
        cmd = 'Mason',
        config = function(plugin)
            -- needed for further usage by mason-lspconfig
            require('mason').setup()
            -- automatic install tools
            local registry = require('mason-registry')
            util.list.foreach(tools, function(tool)
                local package = registry.get_package(tool)
                if not package:is_installed() then
                    package:install()
                end
            end)
        end
    },
    -- diagnostics in separate buffer
    {
        'folke/trouble.nvim',
        cmd = {'TroubleToggle'},
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            require('trouble').setup({
                auto_close = true,
                use_diagnostic_signs = true,
                mode = 'document_diagnostics' -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
            })
        end
    },

    -- code action pretty menu
    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
        keys = {{'\'a', '<cmd>CodeActionMenu<cr>'}}
    },
    -- organize imports for typescript
    {
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        ft = {'typescript', 'typescriptreact'}
    },

}
