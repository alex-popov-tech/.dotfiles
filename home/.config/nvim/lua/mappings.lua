local createMapping = require "utils".createMapping
-- buffers navigation
createMapping("n", "<C-w>", ":w<cr>")
-- " write and exit from current buffer
createMapping("n", "<C-q>", ":bd!<cr>")
-- " do Y to yank till the end of the line
createMapping("n", "Y", "y$")
-- " splits
createMapping("n", "<leader>-", ":split<cr>")
createMapping("n", "<leader>|", ":vsplit<cr>")
-- " reload config
createMapping("n", "<leader>rr", ":source ~/.config/nvim/init.vim<cr>")
-- " remap zl back to zo
createMapping("n", "zl", "zo")
-- " replace selected
createMapping("n", "R", ":%s///g<left><left>")
