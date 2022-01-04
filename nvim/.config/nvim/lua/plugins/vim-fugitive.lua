return function()
    map("n", "<leader>gs", "<cmd>Git | on<cr>")
    map("n", "<leader>gp", "<cmd>exe 'Git push -u origin ' . FugitiveHead()<cr>")
    map("n", "gpf", "<cmd>Git push --force<cr>")
    map("n", "gl", ":diffget //2<cr>")
    map("n", "gr", ":diffget //3<cr>")
end
