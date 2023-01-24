for key, val in pairs({
    laststatus = 3,
    cmdheight = 0, -- hide by default cmd line
    clipboard = 'unnamedplus', -- enable yank/paste to/from system clipboard
    mouse = 'a', -- to visually select and copy from vim without line numbers
    lazyredraw = true, -- Don't redraw while executing macros (good performance config)
    ttyfast = true, -- Don't redraw while executing macros (good performance config)
    hlsearch = false, -- keep searched chunks highlighted
    ignorecase = true, -- search case-insensitive
    smartcase = true, -- if on with ignorecase, when a pattern contains an uppercase letter, it is case sensitive, otherwise it is not
    writebackup = false, -- Turn backup off, since most stuff is in SVN, git et.c anyway...
    swapfile = false, -- disable backups
    backup = false, -- disable backups
    showcmd = true, -- show what commands you typing, what you select in visual mode, etc.
    autowrite = true, -- Automatically :write before running commands
    scrolloff = 5, -- how many lines till window border to see when scrolling
    sidescrolloff = 10, -- same as above but for columns
    shell = '/opt/homebrew/bin/zsh',
    inccommand = 'nosplit', -- incremental search ( enabled by default )
    updatetime = 100, -- timeout for showing cursorhold events, etc
    hidden = true, -- Enable modified buffers in background
    background = 'dark',
    encoding = 'UTF-8',
    showmode = false, -- dont show mode since we have a statusline
    splitkeep = 'screen', -- stabilize buffers position when using splits
    fillchars = {
        eob = ' ',
        fold = ' ',
        foldopen = '',
        foldsep = ' ',
        foldclose = '',
        stlnc = '-',
        vert = '|'
    }, -- splits char
    -- virtualedit = "all", -- make all area 'editable'-ish
    listchars = {tab = '-->', eol = '↩'}, -- replace chars
    list = true, -- Show some invisible characters (tabs...
    signcolumn = 'yes', -- nothing to the left of line number
    foldenable = true, -- don't fold by default
    foldcolumn = '0',
    foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
    foldlevelstart = 99,
    -- foldnestmax = 10, -- deepest fold is 10 levels
    -- foldmethod = "expr", -- fold text using syntax
    -- foldexpr = 'nvim_treesitter#foldexpr()',
    wrap = false, -- when line is longer than the screen, it continues on the next line
    linebreak = true, -- but do not break words, only 'by words'
    number = true, -- show absolute line number
    numberwidth = 1, -- by default 4, and because of that there is empty space to the right to line numbers except current
    relativenumber = true, -- show relative line number for current line
    colorcolumn = '', -- "80,120", -- highlight some column length
    spell = false, -- native spelling, which sucks
    cursorcolumn = true, -- highlight for current column
    cursorline = true, -- Highlight the screen line of the cursor with CursorLine
    completeopt = 'menu,menuone,noselect', -- completion select options
    conceallevel = 3, -- Hide * markup for bold and italic
    confirm = true, -- confirm to save changes before exiting modified buffer
    expandtab = true, -- Use spaces instead of tabs
    smartindent = true, -- Insert indents automatically
    shiftround = true, -- Round indent
    shiftwidth = 2, -- Size of an indent
    tabstop = 2, -- Number of spaces tabs count for
    termguicolors = true, -- True color support
    timeoutlen = 500, -- Time in milliseconds to wait for a mapped sequence to complete.
    wildmode = 'longest:full,full' -- Command-line completion mode
}) do vim.opt[key] = val end

-- TODO fix it
-- vim.opt.shortmess:append({ "s" }) -- better messages

-- vim.opt.formatoptions = "jcroqlnt" -- tcqj
-- vim.opt.grepformat = "%f:%l:%c:%m"
-- vim.opt.pumblend = 10 -- Popup blend
-- vim.opt.pumheight = 10 -- Maximum number of entries in a popup
-- vim.opt.diffopt:append({ "linematch:60" }) -- splits char

vim.g.markdown_recommended_style = 0 -- fix markdown indentation settings
vim.o.shortmess = 'filnxtToOFWIcC'

vim.filetype.add({
    extension = {
        png = 'png',
        jpeg = 'jpeg',
        jpg = 'jpg',
        pug = 'pug',
        jade = 'pug'
    }
})

vim.cmd('cnoreabbrev W noa w')
vim.cmd('cnoreabbrev WA noa wa')

vim.o.statuscolumn =
    '%s' -- .. '%{%v:lua.ScAppropriateLineNo(v:lnum, v:relnum)%}'
    .. '%=' .. '%{%' -- evaluate this, and then evaluate what it returns
    .. '&number ?' .. '(v:relnum ?' ..
        'printf("%"..len(line("$")).."s", v:relnum)' -- when showing relative numbers, make sure to pad so things don't shift as you move the cursor
    .. ':' .. 'v:lnum' .. ')' .. ':' .. '""' .. ' ' -- space between lines and fold
    .. '%}' .. '%=' .. '%#FoldColumn#%{' -- expression for showing fold expand/colapse
    .. 'foldlevel(v:lnum) > foldlevel(v:lnum - 1)' -- any folds?
    .. '? (foldclosed(v:lnum) == -1' -- currently open?
    .. '? ""' -- point down
    .. ': ""' -- point to right
    .. ')' .. ': " "' -- blank for no fold, or inside fold
    .. '}'
