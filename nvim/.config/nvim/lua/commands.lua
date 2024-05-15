vim.api.nvim_create_user_command("Bonly", function()
  local last_buffer_number = vim.fn.bufnr("$")
  for i = 1, last_buffer_number - 1 do
    if vim.fn.buflisted(i) ~= 0 then
      local buf_info = vim.fn.getbufinfo(i)[1]
      local is_modified = buf_info.changed == 1
      local is_focused = buf_info.hidden ~= 1
      if not is_modified and not is_focused then
        vim.cmd(string.format("bd! %d", i))
      end
    end
  end
end, {})
vim.cmd("cnoreabbrev bo silent Bonly")

vim.cmd("cnoreabbrev bd bdelete %")
vim.cmd("cnoreabbrev bd! bdelete! %")
