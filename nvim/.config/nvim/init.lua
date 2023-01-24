vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd('nmap <bs> <leader>')

if not package.loaded.lazy then require('lazyvim') end
require('settings')
require('autocommands')
require('mappings')
require('ui')
