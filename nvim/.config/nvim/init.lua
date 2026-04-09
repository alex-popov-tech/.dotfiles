vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd("nmap <bs> <leader>")
vim.loader.enable(true)

if not package.loaded.lazy then
  require("lazyvim")
end
require("settings")
require("autocommands")
require("mappings")
require("commands")
require("ui")
require("lsp")
