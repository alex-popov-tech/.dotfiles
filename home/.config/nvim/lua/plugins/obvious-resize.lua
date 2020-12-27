local createMapping = require'utils'.createMapping
vim.g.obvious_resize_default = 4
vim.g.obvious_resize_run_tmux = 1
createMapping('', '<c-up>', ':ObviousResizeUp<cr>')
createMapping('', '<c-down>', ':ObviousResizeDown<cr>')
createMapping('', '<c-left>', ':ObviousResizeLeft<cr>')
createMapping('', '<c-right>', ':ObviousResizeRight<cr>')
