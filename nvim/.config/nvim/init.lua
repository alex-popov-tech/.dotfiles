vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("settings")
require("filetype")
require("autocommands")
require("keymaps")
require("commands")
require("ui")
require("lsp")
