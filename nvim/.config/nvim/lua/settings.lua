g.mapleader = " "
cmd("nmap <bs> <leader>")

vim.filetype.add({
  extension = {
    png = 'png',
    jpeg = 'jpeg',
    jpg = 'jpg',
    pug = 'pug',
    jade = 'pug'
  }
})

for key, val in pairs({
  laststatus = 3,
  cmdheight = 0, -- hide by default cmd line
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
  scrolloff = 5, -- how many lines till window border to see when scrolling
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
  showmode = false,
  splitkeep = "screen", -- stabilize buffers position when using splits
  -- foldenable = true, -- don't fold by default
  -- foldnestmax = 10, -- deepest fold is 10 levels
  -- foldmethod = "expr", -- fold text using syntax
  -- foldexpr = 'nvim_treesitter#foldexpr()',
  fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,stlnc:-,vert:|]], -- splits char
  -- virtualedit = "all", -- make all area 'editable'-ish
  diffopt = vim.o.diffopt .. ",linematch:60" -- splits char
}) do
  vim.go[key] = val
end

for key, val in pairs({
  listchars = "space:·,tab:-->,eol:↩", -- replace chars
  list = true,
  signcolumn = "no", -- nothing to the left of line number
  -- foldnestmax = 10, -- deepest fold is 10 levels
  -- foldmethod = "expr", -- fold text using syntax
  -- foldexpr = 'nvim_treesitter#foldexpr()',
  -- foldenable = false, -- don't fold by default
  wrap = false, -- when line is longer than the screen, it continues on the next line
  linebreak = true, -- but do not break words, only 'by words'
  number = true, -- show absolute line number
  numberwidth = 1, -- by default 4, and because of that there is empty space to the right to line numbers except current
  relativenumber = true, -- show relative line number for current line
  colorcolumn = "", -- "80,120", -- highlight some column length
  spell = false, -- "80,120", -- highlight some column length
  cursorcolumn = true, -- highlight for current column
  cursorline = true -- Highlight the screen line of the cursor with CursorLine
}) do
  vim.wo[key] = val
end
-- add chars to '%'
vim.bo.matchpairs = "(:),{:},[:],<:>"

-- blink search matches, not leave them visible
-- vim.api.nvim_create_autocmd("CursorHold", { pattern = { "*" }, callback = function() vim.o.hlsearch = false end })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost",
  { pattern = { "*" }, callback = function() vim.highlight.on_yank({ higroup = "Visual", timeout = 100 }) end })

-- write path when save file if needed
vim.api.nvim_create_autocmd("BufNewFile",
  { pattern = { "*" },
    callback = function() vim.cmd(":exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')") end })
