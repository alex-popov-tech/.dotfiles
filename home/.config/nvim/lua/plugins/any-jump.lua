return function()
    local createMapping = require "utils".createMapping
    -- find/jump definition/reference with fzf
    createMapping("n", "go", ":AnyJump<cr>")
end
