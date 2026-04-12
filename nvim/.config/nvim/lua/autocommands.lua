-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 80 })
  end,
})

-- start terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd.startinsert()
  end,
})

-- create parent directories on save if they don't exist
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(ev)
    -- only for normal file buffers, skip scratch/help/terminal/etc.
    if vim.bo[ev.buf].buftype ~= "" then
      return
    end
    local dir = vim.fn.fnamemodify(ev.file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
