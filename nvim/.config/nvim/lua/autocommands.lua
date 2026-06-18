-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 80 })
  end,
})

-- restore cursor to last position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lcount
      and not vim.tbl_contains({ "commit", "gitrebase" }, vim.bo[ev.buf].filetype)
    then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- hide cursorline in insert mode, restore on leave
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt_local.cursorline = true
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
