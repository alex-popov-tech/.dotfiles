-- UI & window layout --------------------------------------------------------
vim.opt.laststatus = 3 -- global statusline
vim.opt.cmdheight = 0 -- hide cmdline when not in use
vim.opt.showmode = false -- statusline shows mode
vim.opt.splitkeep = "screen" -- stabilize buffer position when splitting
vim.opt.splitbelow = true -- new horizontal splits go below current
vim.opt.splitright = true -- new vertical splits go right of current
vim.opt.winborder = "rounded" -- default border for floating windows
-- (lsp hover, diagnostic floats, :help, etc).
-- plugins with their own border config (blink,
-- fzf-lua) override this.
vim.opt.winblend = 0 -- floating window transparency
vim.opt.pumblend = 0 -- popup menu transparency

-- Line numbers & cursor ------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
vim.opt.cursorline = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "auto" -- only show when there's something (dap breakpoints)

-- Whitespace & indentation ---------------------------------------------------
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.shiftround = true
vim.opt.list = true
vim.opt.listchars = { tab = "->", space = "·", eol = "↩" }
vim.opt.fillchars = {
  fold = " ",
  foldopen = "▾",
  foldsep = " ",
  foldclose = "▸",
  stlnc = "-",
  vert = "│",
  diff = "╱", -- hatch-style filler in diff view
}

-- Wrapping -------------------------------------------------------------------
vim.opt.wrap = false
vim.opt.linebreak = true -- only matters when wrap is on, but harmless
vim.opt.breakindent = true -- preserve indent on wrapped lines

-- Folding (used with ufo) ----------------------------------------------------
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Search ---------------------------------------------------------------------
vim.opt.hlsearch = false -- custom blink-on-search in keymaps.lua
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split" -- live substitution preview

-- Completion & popup ---------------------------------------------------------
vim.opt.completeopt = "menu,menuone,noselect,fuzzy" -- fuzzy is 0.11+
vim.opt.pumheight = 10
vim.opt.wildmode = "longest:full,full"

-- Files & undo ---------------------------------------------------------------
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true -- persistent undo
vim.opt.autowrite = true -- auto :write before running commands
vim.opt.confirm = true -- prompt on unsaved exit

-- Timings --------------------------------------------------------------------
vim.opt.updatetime = 100 -- cursorhold / gitsigns / lsp highlight delay
vim.opt.timeoutlen = 500 -- key sequence timeout

-- Clipboard & colors ---------------------------------------------------------
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Jumplist & scrolling -------------------------------------------------------
vim.opt.jumpoptions = "stack,view,clean" -- browser-like jumps + restore view
vim.opt.smoothscroll = true -- smooth C-d/C-u with wrapped lines

-- Markdown / concealing ------------------------------------------------------
vim.opt.conceallevel = 2

-- Spelling -------------------------------------------------------------------
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Messages -------------------------------------------------------------------
-- see :h 'shortmess' for flag meanings
vim.opt.shortmess = "otTACFOWcs"

-- Diff -----------------------------------------------------------------------
vim.opt.diffopt:append("linematch:60")

-- TODO fix it
-- vim.opt.shortmess:append({ "s" })

-- 3rd party ------------------------------------------------------------------
vim.g.markdown_recommended_style = 0 -- fix markdown indent
