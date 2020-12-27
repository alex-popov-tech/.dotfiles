local createMapping = require "utils".createMapping

vim.cmd("cnoreabbrev gp Gpush")
vim.cmd("command Gs :Git | on")
vim.cmd("cnoreabbrev gs Gs")
createMapping('n', 'gm', ':diffget //2<cr>')
createMapping('n', 'gt', ':diffget //3<cr>')
