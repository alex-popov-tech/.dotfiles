return function()
  -- cmd("imap <expr> <c-l> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<c-l>'")
  -- cmd("imap <expr> <tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<tab>'")
  map("i", "<c-l>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<c-l>'", { expr = true})
  map("i", "<tab>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<tab>'", { expr = true})
  g.vsnip_snippet_dir = fn.stdpath("config") .. "/vsnip"
end
