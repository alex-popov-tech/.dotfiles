local createMapping = require "utils".createMapping
local go = vim.o
local bo = vim.bo
local wo = vim.wo
local v = vim.cmd

vim.g.mapleader = " "
createMapping("n", "<bs>", "<leader>")
createMapping("n", "<space>", "<leader>")
-- enable yank/paste to/from system clipboard
go.clipboard = "unnamedplus"
-- to visually select and copy from vim without line numbers
if vim.fn.has("mouse") == 1 then
  go.mouse = "a"
end
-- Don't redraw while executing macros (good performance config)
go.lazyredraw = true
go.ttyfast = true
-- add chars to '%'
bo.matchpairs = "(:),{:},[:],<:>"
-- highlight for current line
wo.cursorline = true
-- highlight for current column
wo.cursorcolumn = true
-- deepest fold is 10 levels
wo.foldnestmax = 10
-- don't fold by default
wo.foldenable = false
-- fold text using syntax
wo.foldmethod = "syntax"
-- when line is longer than the screen, it continues on the next line
wo.wrap = true
-- but do not break words, only 'by words'
wo.linebreak = true
-- show absolute line number
wo.number = true
wo.relativenumber = true
-- keep searched chunks hightlighted
go.hlsearch = true
vim.cmd("autocmd cursorhold * set nohlsearch")
createMapping("n", "n", ":set hlsearch <cr>n")
createMapping("n", "N", ":set hlsearch <cr>N")
createMapping("n", "/", ":set hlsearch <cr>/")
createMapping("n", "?", ":set hlsearch <cr>?")
-- search case-insensitive
go.ignorecase = true
-- if on with ignorecase, when a pattern contains an uppercase letter, it is
-- case sensitive, otherwise it is not
go.smartcase = true
-- when using * # ignore smart case
-- nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
-- nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>
-- Turn backup off, since most stuff is in SVN, git et.c anyway...
go.writebackup = false
go.swapfile = false
go.backup = false
-- show what commands you typing, what you select in visual mode, etc.
go.showcmd = true
-- Automatically :write before running commands
go.autowrite = true
-- when scrolling screen via f.e. J and K how many lines should be to the
-- bottom of the page (for scroll to trigger you need be at 5 line from bottom
-- and press 'j')
go.scrolloff = 5
-- same as above but for columns
go.sidescrolloff = 10
-- resize signcolumn size dynamically depending on context
go.signcolumn = "no"
-- make inner terminal zsh
go.shell = "/usr/local/bin/zsh"
-- Keep undo history across sessions, by storing in file.
-- Only works all the time.
if vim.fn.has("persistent_undo") then
  os.execute("mkdir " .. os.getenv("HOME") .. "/.vim/backups > /dev/null 2>&1")
  go.undodir = os.getenv("HOME") .. "/.vim/backups"
  go.undofile = true
end
go.inccommand = "nosplit"
-- write path when save file if needed
vim.cmd("autocmd BufNewFile * :exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')")
-- go.backspace = 2
-- refresh things faster
go.updatetime = 300
-- -- go.completeopt  to have a better completion experience
go.completeopt = "menu,noinsert,noselect"
-- better messages
go.shortmess = go.shortmess .. "s"
-- TextEdit might fail if hidden is not set.
go.hidden = true
go.termguicolors = true
go.background = "dark"
wo.signcolumn = "no"
vim.cmd("syntax on")

-- tmux-like zoom in vim
zoomToggle = function()
  if 1 == vim.fn.winnr("$") then
    return
  end
  local restoreCmd = vim.fn.winrestcmd()
  vim.api.nvim_command("wincmd |")
  vim.api.nvim_command("wincmd _")
  -- If the layout did not change, it's a toggle (un-zoom).
  if restoreCmd == vim.fn.winrestcmd() then
    vim.cmd("exe t:zoom_restore")
  else
    vim.t.zoom_restore = restoreCmd
  end
  return
end
createMapping("n", "<leader>z", ':call luaeval("zoomToggle")()<cr>')
