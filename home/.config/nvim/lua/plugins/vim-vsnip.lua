return function()
    cmd("imap <expr> <tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<tab>'")
    cmd("imap <expr> <s-tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>'")
    g.vsnip_extra_mapping = false
    g.vsnip_snippet_dir = fn.stdpath("config") .. "/vsnip"
end
