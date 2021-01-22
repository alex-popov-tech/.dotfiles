return function()
  require"bufferline".setup()

    map("n", "<S-Up>", ":BufferLineCycleNext<cr>")
    map("n", "<S-Down>", ":BufferLineCyclePrev<cr>")
end
