require('impatient')
require("init")

local Path = require "plenary.path"
local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
pcall(vim.cmd, 'source ' .. absolute_cwd .. '/' .. '.conf.lua')
