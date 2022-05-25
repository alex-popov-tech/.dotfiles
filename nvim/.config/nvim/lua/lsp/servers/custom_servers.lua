local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local servers = require 'nvim-lsp-installer.servers'
local server = require 'nvim-lsp-installer.server'
--  local path = require 'nvim-lsp-installer.path'
local npm = require 'nvim-lsp-installer.core.managers.npm'
local null_ls = require('null-ls')
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local general_on_attach = require("lsp.on_attach")

local custom_servers = {
    {
        server_name = 'ls_emmet',
        async = true,
        lspconfig = {
            default_config = {
                filetypes = {
                    'html',
                    'typescriptreact',
                    'javascriptreact',
                    'css'
                },
                root_dir = function()
                    return lspconfig.util.find_git_ancestor(vim.fn.getcwd()) or
                               lspconfig.util
                                   .find_package_json_ancestor(vim.fn.getcwd())
                end
            }
        },
        installer_server = server.Server:new{
            name = 'ls_emmet',
            async = true,
            root_dir = server.get_server_root_path('ls_emmet'),
            installer = npm.packages {'ls_emmet'},
            default_options = {
              cmd_env = npm.env(server.get_server_root_path('ls_emmet'))
                --  cmd = {
                    --  path.concat {
                        --  server.get_server_root_path('ls_emmet'),
                        --  'node_modules',
                        --  '.bin',
                        --  'ls_emmet'
                    --  },
                    --  '--stdio'
                --  }
            }
        }
    }
}

for _, config in pairs(custom_servers) do
    configs[config.server_name] = config.lspconfig
    servers.register(config.installer_server)
end

null_ls.setup({
    sources = {
        formatting.prettierd,
        formatting.fixjson,
        formatting.lua_format,
        diagnostics.eslint_d.with({timeout = 10000}),
        diagnostics.yamllint,
        diagnostics.markdownlint,
        diagnostics.proselint
            .with({extra_filetypes = {'markdown'}}),
        code_actions.eslint_d,
        code_actions.proselint
    },
    on_attach = general_on_attach
})
