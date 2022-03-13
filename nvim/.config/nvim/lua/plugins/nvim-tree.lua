return function()
    map('n', '<c-f>', function()
        if ft() == 'NvimTree' or ft() == 'startify' then
            vim.cmd('NvimTreeToggle')
        else
            vim.cmd('NvimTreeFindFile')
        end
    end)
    g.nvim_tree_side = 'left'
    g.nvim_tree_width = 30
    --  g.nvim_tree_quit_on_open = 1
    g.nvim_tree_indent_markers = 1
    g.nvim_tree_git_hl = 1
    g.nvim_tree_allow_resize = 1
    g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1}
    g.nvim_tree_icons = {
        default = '',
        symlink = '',
        git = {
            unstaged = '✗',
            staged = '✓',
            unmerged = '',
            renamed = '➜',
            untracked = '★'
        },
        folder = {default = '', open = ''}
    }
    require'nvim-tree'.setup {
        auto_close = true,
        view = {width = 50, side = 'right'},
        actions = {
            open_file = {quit_on_open = true}
        }
    }
end
