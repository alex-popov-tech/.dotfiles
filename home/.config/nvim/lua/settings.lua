g.mapleader = " "

for key, val in pairs(
    {
        clipboard = "unnamedplus", -- enable yank/paste to/from system clipboard
        mouse = "a", -- to visually select and copy from vim without line numbers
        lazyredraw = true,
        -- Don't redraw while executing macros (good performance config)
        ttyfast = true, -- Don't redraw while executing macros (good performance config)
        hlsearch = true, -- keep searched chunks hightlighted
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
        inccommand = "nosplit",
        updatetime = 300, -- timeout for showing completions, cursorhold events, etc
        completeopt = "menu,noinsert,noselect", -- how window for completion will look like
        shortmess = vim.o.shortmess .. "s", -- better messages
        -- TextEdit might fail if hidden is not set.
        hidden = true,
        termguicolors = true,
        background = "dark",
        encoding = "UTF-8",
    }
) do
    vim.o[key] = val
end
for key, val in pairs(
    {
        signcolumn = "no", -- nothing to the left of line number
        cursorcolumn = true, -- highlight for current column
        foldnestmax = 10, -- deepest fold is 10 levels
        foldenable = false, -- don't fold by default
        foldmethod = "syntax", -- fold text using syntax
        wrap = true, -- when line is longer than the screen, it continues on the next line
        linebreak = true, -- but do not break words, only 'by words'
        number = true, -- show absolute line number
        relativenumber = true, -- show relative line number for current line
        cursorline = true -- Highlight the screen line of the cursor with CursorLine
    }
) do
    vim.wo[key] = val
end
-- add chars to '%'
vim.bo.matchpairs = "(:),{:},[:],<:>"

map("n", "<bs>", "<leader>")
map("n", "<space>", "<leader>")

-- blink search matches, not leave them visible
au("cursorhold", "*", "set nohlsearch")
map("n", "n", ":set hlsearch <cr>n")
map("n", "N", ":set hlsearch <cr>N")
map("n", "/", ":set hlsearch <cr>/")
map("n", "?", ":set hlsearch <cr>?")
-- when using * # ignore smart case
_G['*'] = function()
  vim.o.ignorecase = false
  vim.o.smartcase = false
  cmd('/' .. fn.expand('<cword>'))
  vim.o.ignorecase = true
  vim.o.smartcase = true
end
_G['#'] = function()
  vim.o.ignorecase = false
  vim.o.smartcase = false
  cmd('?' .. fn.expand('<cword>'))
  vim.o.ignorecase = true
  vim.o.smartcase = true
end
-- case-sensative search for * and #
map("n", "*", ":lua _G['*']()<cr>")
map("n", "#", ":lua _G['#']()<cr>")

-- Keep undo history across sessions, by storing in file.
-- Only works all the time.
if fn.has("persistent_undo") then
    os.execute("mkdir " .. os.getenv("HOME") .. "/.vim/backups > /dev/null 2>&1")
    vim.o.undodir = os.getenv("HOME") .. "/.vim/backups"
    vim.o.undofile = true
end

-- write path when save file if needed
au("BufNewFile", "*", ":exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')")

cmd("syntax on")

-- tmux-like zoom in vim
function _toggleZoom()
    if 1 == vim.fn.winnr("$") then
        return
    end
    local restoreCmd = vim.fn.winrestcmd()
    cmd("wincmd |")
    cmd("wincmd _")
    -- If the layout did not change, it's an un-zoom.
    if restoreCmd == vim.fn.winrestcmd() then
        cmd("exe t:zoom_restore")
    else
        vim.t.zoom_restore = restoreCmd
    end
    return
end
map("n", "<leader>z", ':lua _toggleZoom()<cr>')
