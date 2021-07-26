return function()
    vim.cmd("nmap <leader>cc <Plug>CommentaryLine")
    vim.cmd("xmap <leader>c <Plug>Commentary")
    vim.cmd("omap <leader>c <Plug>Commentary")
    vim.cmd("nmap <leader>c <Plug>Commentary")
end
