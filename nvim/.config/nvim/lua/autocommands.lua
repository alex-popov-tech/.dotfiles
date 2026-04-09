-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- write path when save file if needed
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = { "*" },
  callback = function()
    vim.cmd(":exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')")
  end,
})

-- blink matches on searching
-- local ns = vim.api.nvim_create_namespace('toggle_hlsearch')
-- vim.on_key(function(char)
--     if vim.fn.mode() == 'n' then
--         local keys = {'<CR>', 'n', 'N', '*', '#', '?', '/'}
--         local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))
--
--         if vim.opt.hlsearch:get() ~= new_hlsearch then
--             vim.opt.hlsearch = new_hlsearch
--         end
--     end
-- end, ns)

-- disable line numbers and enable wrap for claude markdown files
vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*/claude-prompt-*.md", "claude-prompt-*.md" },
  callback = function()
    vim.schedule(function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.wrap = true
    end)
  end,
})

-- complete 'as' and 'a' to 'async' and 'await'
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function(ev)
    vim.keymap.set("i", "<Space>", function()
      local col = vim.fn.col(".") -- cursor col (1-based)
      local line = vim.fn.getline(".") -- whole line
      local before = line:sub(1, col - 1)

      -- check if inside comment (//)
      if before:match("//") then
        return "<Space>"
      end

      -- async -> expand 'as ' → 'async '
      if before:sub(-3) == " as" then
        return "<BS><BS>async "
      end

      -- await -> expand 'a ' → 'await '
      if before:sub(-2) == " a" then
        return "<BS>await "
      end

      return "<Space>"
    end, { expr = true, buffer = ev.buf })
  end,
})
