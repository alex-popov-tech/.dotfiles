local map = require "utils".map
-- buffers navigation
map("n", "<S-Up>", ":bn<cr>")
map("n", "<S-Down>", ":bp<cr>")
map("n", "<C-w>", ":w<cr>")
-- " write and exit from current buffer
map("n", "<C-q>", ":w<cr>")
-- " do Y to yank till the end of the line
map("n", "Y", "y$")
-- " splits
map("n", "<leader>-", ":split<cr>")
map("n", "<leader>|", ":vsplit<cr>")
-- " reload config
map("n", "<leader>rr", ":source ~/.config/nvim/init.vim<cr>")
-- " remap zl back to zo
map("n", "zl", "zo")
-- " replace selected
map("n", "R", ":%s///g<left><left>")
