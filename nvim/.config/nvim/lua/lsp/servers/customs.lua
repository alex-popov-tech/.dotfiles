local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local servers = require 'nvim-lsp-installer.servers'
local server = require 'nvim-lsp-installer.server'
local path = require 'nvim-lsp-installer.path'
local npm = require 'nvim-lsp-installer.installers.npm'

local custom_servers = {
    {
        server_name = 'ls_emmet',
        lspconfig = {
            default_config = {
                filetypes = {
                    'html',
                    'typescriptreact',
                    'javascriptreact',
                    'javascript',
                    'typescript',
                    'javascript.jsx',
                    'typescript.tsx',
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
            root_dir = server.get_server_root_path('ls_emmet'),
            installer = npm.packages {'ls_emmet'},
            default_options = {
                cmd = {
                    path.concat {
                        server.get_server_root_path('ls_emmet'),
                        'node_modules',
                        '.bin',
                        'ls_emmet'
                    },
                    '--stdio'
                }
            }
        }
    }
}

for _, config in pairs(custom_servers) do
  configs[config.server_name] = config.lspconfig
  servers.register(config.installer_server)
end
