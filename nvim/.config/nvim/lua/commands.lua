-- :Bonly — delete all listed, unmodified, non-visible buffers
vim.api.nvim_create_user_command("Bonly", function()
  vim.iter(vim.api.nvim_list_bufs())
    :filter(function(buf)
      return vim.bo[buf].buflisted
        and not vim.bo[buf].modified
        and vim.fn.bufwinnr(buf) == -1
    end)
    :each(function(buf)
      vim.api.nvim_buf_delete(buf, { force = true })
    end)
end, { desc = "Delete all non-visible, unmodified buffers" })

-- :bo → :Bonly
vim.keymap.set("ca", "bo", "Bonly")
