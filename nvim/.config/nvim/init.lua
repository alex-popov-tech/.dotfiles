-- local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
-- vim.opt.rtp:append(snacks)
-- require("snacks.profiler").startup({
--   startup = {
--     event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
--     -- event = "UIEnter",
--     -- event = "VeryLazy",
--   },
-- })

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd("nmap <bs> <leader>")

if not package.loaded.lazy then
  require("lazyvim")
end
require("settings")
require("autocommands")
require("mappings")
require("commands")
require("ui")
require("lsp")

-- vim.opt.runtimepath:append("/Users/alex/me/pet/store.nvim")
