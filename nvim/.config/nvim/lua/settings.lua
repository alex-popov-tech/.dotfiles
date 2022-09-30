g.mapleader = " "
cmd("nmap <bs> <leader>")

vim.filetype.add({
  extension = {
    png ='png',
    jpeg = 'jpeg',
    jpg = 'jpg',
    pug = 'pug',
    jade = 'pug'
  }
})

for key, val in pairs({
  laststatus = 3,
  cmdheight = 0,
  clipboard = "unnamedplus", -- enable yank/paste to/from system clipboard
  mouse = "a", -- to visually select and copy from vim without line numbers
  lazyredraw = true, -- Don't redraw while executing macros (good performance config)
  ttyfast = true, -- Don't redraw while executing macros (good performance config)
  hlsearch = false, -- keep searched chunks highlighted
  ignorecase = true, -- search case-insensitive
  smartcase = true, -- if on with ignorecase, when a pattern contains an uppercase letter, it is case sensitive, otherwise it is not
  writebackup = false, -- Turn backup off, since most stuff is in SVN, git et.c anyway...
  swapfile = false,
  backup = false,
  showcmd = true, -- show what commands you typing, what you select in visual mode, etc.
  autowrite = true, -- Automatically :write before running commands
  scrolloff = 2, -- how many lines till window border to see when scrolling
  sidescrolloff = 10, -- same as above but for columns
  shell = "/usr/local/bin/zsh",
  -- inccommand = "nosplit", -- incremental search ( enabled by default )
  updatetime = 100, -- timeout for showing cursorhold events, etc
  shortmess = vim.o.shortmess .. "s", -- better messages
  -- TextEdit might fail if hidden is not set.
  hidden = true,
  termguicolors = true,
  background = "dark",
  encoding = "UTF-8",
  list = true,
  listchars = "space:·,tab:»»,eol:↩", -- replace chars
  fillchars = "stlnc:-,vert:¦" -- splits char
}) do
  vim.o[key] = val
end

for key, val in pairs({
  signcolumn = "no", -- nothing to the left of line number
  foldnestmax = 10, -- deepest fold is 10 levels
  foldenable = false, -- don't fold by default
  foldmethod = "syntax", -- fold text using syntax
  wrap = false, -- when line is longer than the screen, it continues on the next line
  linebreak = true, -- but do not break words, only 'by words'
  number = true, -- show absolute line number
  numberwidth = 1, -- by default 4, and because of that there is empty space to the right to line numbers except current
  relativenumber = true, -- show relative line number for current line
  cursorcolumn = true, -- highlight for current column
  colorcolumn = "", -- "80,120", -- highlight some column length
  spell = true, -- "80,120", -- highlight some column length
  cursorline = true -- Highlight the screen line of the cursor with CursorLine
}) do
  vim.wo[key] = val
end
-- add chars to '%'
vim.bo.matchpairs = "(:),{:},[:],<:>"

-- blink search matches, not leave them visible
vim.api.nvim_create_autocmd("CursorHold", { pattern = { "*" }, callback = function() vim.cmd("set nohlsearch") end })
-- vim.api.nvim_create_autocmd("BufEnter", { pattern = { "*.png" }, callback = function() vim.bo.filetype = "png" end })
-- vim.api.nvim_create_autocmd("BufEnter", { pattern = { "*.jpg" }, callback = function() vim.bo.filetype = "jpeg" end })
-- vim.api.nvim_create_autocmd("BufEnter", { pattern = { "*.jpeg" }, callback = function() vim.bo.filetype = "jpeg" end })
-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", { pattern = { "*" }, callback = function() vim.highlight.on_yank({ higroup = "Visual", timeout = 100 }) end })

-- Keep undo history across sessions, by storing in file.
-- Only works all the time.
-- if fn.has("persistent_undo") then
--   os.execute("mkdir " .. os.getenv("HOME") .. "/.vim/backups > /dev/null 2>&1")
--   vim.o.undodir = os.getenv("HOME") .. "/.vim/backups"
--   vim.o.undofile = true
-- end

-- write path when save file if needed
vim.api.nvim_create_autocmd("BufNewFile", { pattern = {"*"}, callback = function() vim.cmd(":exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')") end })

cmd("syntax on")
