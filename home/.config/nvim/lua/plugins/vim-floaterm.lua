return function()
    local createMapping = require "utils".createMapping
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    createMapping("n", "<F11>", ":FloatermToggle<cr>")
    createMapping("t", "<F11>", "<c-\\><c-n>:FloatermToggle<cr>")
end
