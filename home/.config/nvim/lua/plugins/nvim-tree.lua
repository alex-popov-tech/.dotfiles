local createMapping = require'utils'.createMapping
createMapping('n', '<c-f>', ':LuaTreeToggle<cr>')
vim.g.lua_tree_side = 'left'
vim.g.lua_tree_width = 30
vim.g.lua_tree_auto_close = 1
vim.g.lua_tree_quit_on_open = 1
vim.g.lua_tree_follow = 1
vim.g.lua_tree_indent_markers = 1
vim.g.lua_tree_git_hl = 1
vim.g.lua_tree_allow_resize = 1
vim.g.lua_tree_show_icons = { git = 1, folders = 1, files = 1 }
vim.g.lua_tree_bindings = {
  edit = { '<CR>', 'l' },
  edit_vsplit = '<C-v>',
  edit_split = '<C-x>',
  close_node = { '<S-CR>', 'h' },
  refresh = 'R',
  create = 'a',
  remove = 'd',
  rename = 'r',
  cut = 'x',
  copy = 'y',
  paste = 'p',
}
vim.g.lua_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '✗',
    staged = '✓',
    unmerged = '',
    renamed = '➜',
    untracked = '★'
  },
  folder = {
    default = '',
    open = ''
  }
}

