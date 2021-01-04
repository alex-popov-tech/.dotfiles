return function()
    local createMapping = require "utils".createMapping
    require "bufferline".setup()
    createMapping("n", "<S-Up>", ":BufferLineCycleNext<cr>")
    createMapping("n", "<S-Down>", ":BufferLineCyclePrev<cr>")
end
