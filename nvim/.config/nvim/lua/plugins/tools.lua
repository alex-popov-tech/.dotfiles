return {
    {
        'williamboman/mason.nvim',
        event = 'BufReadPre',
        cmd = 'Mason',
        build = ':MasonUpdate',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            {'neovim/nvim-lspconfig', branch = 'master'},
            'folke/neodev.nvim',
            'jay-babu/mason-null-ls.nvim',
            'jose-elias-alvarez/null-ls.nvim'
            -- 'mfussenegger/nvim-dap',
            -- 'jay-babu/mason-nvim-dap.nvim',
            -- 'rcarriga/nvim-dap-ui'
        },
        config = function()
            require('mason').setup()
            -- ================ LSP SETUP ================
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'tsserver',
                    'cssls',
                    'jsonls',
                    'yamlls',
                    'tailwindcss',
                    'emmet_ls',
                    'prismals',
                    'gopls'
                },
                automatic_installation = true
            })
            require('neodev').setup({
                library = {plugins = {'nvim-dap-ui'}, types = true}
            })
            local general_on_attach = require('lsp.on_attach')
            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    local opts = require('lsp.servers.' .. server_name)(
                                     general_on_attach)
                    opts.flags = {
                        debounce_text_changes = 100,
                        lintDebounce = 200
                    }
                    opts.capabilities = opts.capabilities or
                                            vim.lsp.protocol
                                                .make_client_capabilities()
                    require('lspconfig')[server_name].setup(opts)
                end
            })
            -- ================ LSP SETUP ================
            -- =============== TOOLS SETUP ===============
            local null_ls = require('null-ls')
            local diagnostics = null_ls.builtins.diagnostics
            local formatting = null_ls.builtins.formatting
            local code_actions = null_ls.builtins.code_actions

            null_ls.setup({
                debounce = 150,
                update_in_insert = false,
                sources = {
                    formatting.prettierd,
                    formatting.lua_format,
                    formatting.yamlfmt,
                    formatting.gofmt,
                    formatting.goimports_reviser,
                    formatting.golines,

                    diagnostics.selene,
                    diagnostics.eslint_d.with({timeout = 10000}),

                    code_actions.gitsigns
                }
            })
            require('mason-null-ls').setup({
                ensure_installed = {
                    'eslint_d',
                    'prettierd',
                    'selene',
                    'luaformatter',
                    'goimports-reviser',
                    'golines'
                },
                automatic_installation = true,
                automatic_setup = false
            })
            -- =============== TOOLS SETUP ===============
            -- ================ DAP SETUP ================
            -- local dap, dapui = require('dap'), require('dapui')
            -- require('mason-nvim-dap').setup({
            --     ensure_installed = {'delve'},
            --     automatic_installation = true,
            --     automatic_setup = true
            -- })
            -- require'mason-nvim-dap'.setup_handlers {}
            -- dap.listeners.after.event_initialized['dapui_config'] = function()
            --     dapui.open()
            -- end
            -- dap.listeners.before.event_terminated['dapui_config'] = function()
            --     dapui.close()
            -- end
            -- dap.listeners.before.event_exited['dapui_config'] = function()
            --     dapui.close()
            -- end
            -- ================ DAP SETUP ================
        end
    }
}
