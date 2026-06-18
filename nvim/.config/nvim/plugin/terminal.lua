-- floating terminal toggle. <F11> opens a near-fullscreen terminal in a
-- floating window. pressing <F11> again hides it (process keeps running).

local term_buf = nil
local term_win = nil

local function toggle()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_hide(term_win)
    term_win = nil
    return
  end

  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    term_buf = vim.api.nvim_create_buf(false, true)
  end

  local width = math.floor(vim.o.columns * 0.99)
  local height = math.floor(vim.o.lines * 0.99)
  term_win = vim.api.nvim_open_win(term_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
  })

  if vim.bo[term_buf].buftype ~= "terminal" then
    vim.cmd.terminal()
    vim.bo[term_buf].buflisted = false
  end
  vim.cmd.startinsert()
end

vim.keymap.set({ "n", "t" }, "<F11>", toggle)
