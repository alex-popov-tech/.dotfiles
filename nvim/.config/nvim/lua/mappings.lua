for _, mappings in pairs({
  -- {'n', '<c-w>', ':w<cr>'},
  { "n", "<C-q>", "ZZ" }, -- write and exit from current buffer
  { "n", "Y", "y$" }, -- do Y to yank till the end of the line
  -- split and navigate to it
  { "n", "<up>", ":bn<cr>" },
  { "n", "<down>", ":bp<cr>" },
  { "n", "<leader>s", ":split | wincmd j<cr>" },
  { "n", "<leader>v", ":vsplit | wincmd l<cr>" },
  { "n", "zl", "zo" }, -- remap zl back to zo
  -- replace selected
  { "n", "R", ":%s///gI<left><left><left>" },
  -- if press 'a' no empty line it should respect indent
  { "n", "a", "len(getline('.')) == 0 ? 'S' : 'a'", { expr = true } },
  -- show last commands list on last item
  { "n", "Q", "q:dd" },
  -- blink on next match
  {
    "n",
    "n",
    function()
      vim.cmd("norm! nzz")
      vim.opt.hlsearch = true
      vim.defer_fn(function()
        vim.opt.hlsearch = false
      end, 200)
    end,
    { noremap = true, remap = true },
  },
  {
    "n",
    "N",
    function()
      vim.cmd("norm! Nzz")
      vim.opt.hlsearch = true
      vim.defer_fn(function()
        vim.opt.hlsearch = false
      end, 200)
    end,
    { noremap = true, remap = true },
  },
  {
    "n",
    "*",
    function()
      vim.cmd("norm! *zz")
      vim.opt.hlsearch = true
      vim.defer_fn(function()
        vim.opt.hlsearch = false
      end, 200)
    end,
    { noremap = true, remap = true },
  },
  -- magic search mappnigs
  { "n", "/", "/\\v", { noremap = true } },
  { "v", ":s/", ":s/\\v", { noremap = true } },
  { "c", "%s/", "%s/\\v", { noremap = true } },
  { "c", "%s/", "%s/\\v", { noremap = true } },
  {
    "n",
    "<c-a>",
    function()
      local word_under_cursor = vim.fn.expand("<cword>")
      if word_under_cursor == "true" then
        vim.cmd("normal ciwfalse")
        return
      elseif word_under_cursor == "false" then
        vim.cmd("normal ciwtrue")
        return
      end
      vim.cmd("normal! ")
    end,
    { noremap = true },
  },
  { "n", "<leader>c", "gc", { remap = true } },
  { "n", "<leader>cc", "gcc", { remap = true } },
  { "v", "<leader>c", "gc", { remap = true } },
}) do
  local mode = mappings[1]
  local lhs = mappings[2]
  local rhs = mappings[3]
  local options = mappings[4] or { silent = true }
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Define modes and delete mappings to be replaced
local modes = { "n", "v" }
local delete_mappings = {
  d = '"_d',
  D = '"_D',
  x = '"_x',
  X = '"_X',
}
-- Iterate over the modes and set the new mappings
-- for _, mode in ipairs(modes) do
--   for lhs, rhs in pairs(delete_mappings) do
--     vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
--   end
-- end

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
      if before:sub(-2) == "as" then
        return "<BS><BS>async "
      end

      -- await -> expand 'a ' → 'await '
      if before:sub(-1) == "a" then
        return "<BS>await "
      end

      return "<Space>"
    end, { expr = true, buffer = ev.buf })
  end,
})

vim.keymap.set('v', 'ai', function()
  local a, b = vim.fn.line('v'), vim.fn.line('.')
  local start_line, end_line = math.min(a, b), math.max(a, b)
  local filepath = vim.fn.expand('%:p')
  local ft = (vim.bo.filetype ~= '' and vim.bo.filetype) and vim.bo.filetype or 'text'
  local content = table.concat(vim.fn.getline(start_line, end_line), '\n')

  local function pick_fence(s)
    for n = 3, 8 do
      local f = string.rep('`', n)
      if not s:find(f, 1, true) then return f end
    end
    return '~~~~' -- fallback
  end

  local fence = pick_fence(content)
  local header = string.format('%s:%d:%d', filepath, start_line, end_line)
  local result = string.format('%s\n%s%s\n%s\n%s', header, fence, ft, content, fence)

  vim.fn.setreg('+', result)
  print('📋 Copied file info + content (with autodetected filetype)')
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end, { desc = 'Copy file path, range, and content as fenced code block' })
