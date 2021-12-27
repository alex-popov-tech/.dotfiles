for _, mappings in pairs(
    {
        {"n", "<c-w>", ":w<cr>"},
        {"n", "<C-q>", "ZZ"}, -- write and exit from current buffer
        {"n", "Y", "y$"}, -- do Y to yank till the end of the line
        -- split and navigate to it
        {"n", "<shift><up>", ":bn"},
        {"n", "<shift><down>", ":bp"},
        {"n", "<leader>-", ":split | wincmd j<cr>"},
        {"n", "<leader>|", ":vsplit | wincmd l<cr>"},
        {"n", "zl", "zo"}, -- remap zl back to zo
        -- replace selected
        {"n", "R", ":%s///gI<left><left><left>"},
        -- if press 'a' no empty line it should respect indent
        {"n", "a", "len(getline('.')) == 0 ? 'S' : 'a'", { expr = true }},
        -- show last commands list on last item
        {"n", "Q", "q:dd"},
        -- map to drop into { } block
        {"i", "{<cr>", "{}<left><cr><esc>O"},
        {"i", "{<space>", "{}<left><space><left><space>"},
        {"i", "(<cr>", "()<left><cr><esc>O"},
        {"i", "(<space>", "()<left><space><left><space>"},
        {"i", "({<space>", "({})<left><left><space><left><space>"},
        {"i", "({<cr>", "({})<left><left><cr><esc>O"},
        -- jump with  and stay cursor in center of the screen
        {"n", "*", ":set hlsearch<cr>*zz", { noremap = true }},
        {"n", "n", ":set hlsearch<cr>nzz", { noremap = true }},
        {"n", "N", ":set hlsearch<cr>Nzz", { noremap = true }},
        -- stay cursor on place when 'J'
        {"n", "J", "mzJ`z"},
        -- move selected lines up and down
        {"v", "J", ":m '>+1<cr>gv=gv"},
        {"v", "K", ":m '<-2<cr>gv=gv"},
        -- do not yank on x/X
        {"n", "x", '"_dl'},
        {"n", "X", '"_dh'},
    }
) do
    local mode = mappings[1]
    local key = mappings[2]
    local value = mappings[3]
    local options = mappings[4]
    map(mode, key, value, options)
end

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
map("n", "<leader>z", ":lua _toggleZoom()<cr>")

au("BufNewFile, BufReadPost", "*.pug", "set filetype=pug")
au("BufNewFile, BufReadPost", "*.jade", "set filetype=pug")

cmd("cnoreabbrev W noa w")
cmd("cnoreabbrev WA noa wa")
