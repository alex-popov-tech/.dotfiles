return function()
    local createMapping = require "utils".createMapping
    -- Write all buffers before navigating from Vim to tmux pane
    vim.g.tmux_navigator_save_on_switch = 2
    vim.g.tmux_navigator_no_mappings = 1
    createMapping("", "<c-h>", ":TmuxNavigateLeft<cr>")
    createMapping("", "<c-j>", ":TmuxNavigateDown<cr>")
    createMapping("", "<c-k>", ":TmuxNavigateUp<cr>")
    createMapping("", "<c-l>", ":TmuxNavigateRight<cr>")
end
