local utils = require'utils'
local map = utils.map
local range = utils.range
vim.g.startify_lists = {{ type = "dir", header = { ' Most recently updated in ' .. vim.fn.getcwd() } }}
-- use vsc root when enter file
vim.g.startify_change_to_vcs_root = 1
-- do not show 'edit' and 'quit' options
vim.g.startify_enable_special = 1
-- start from 1 when choosing
vim.g.startify_custom_indices = {'a','r','s','t','n','e','o','i', 1,2,3,4,7,8,9,0}
