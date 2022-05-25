return function()
    --  map('n', '<c-f>', function()
    --  if ft() == 'NvimTree' or ft() == 'startify' then
    --  vim.cmd('Neotree toggle current reveal_force_cwd')
    --  else
    --  vim.cmd('NvimTreeFindFile')
    --  end
    --  end)
    vim.cmd [[ nmap <c-f> :Neotree position=float reveal<cr>]]

    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require('neo-tree').setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = false,
        default_component_configs = {
            indent = {
                indent_size = 2,
                padding = 1, -- extra padding on left hand side
                -- indent guides
                with_markers = true,
                indent_marker = '│',
                last_indent_marker = '└',
                highlight = 'NeoTreeIndentMarker',
                -- expander config, needed for nesting files
                with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = '',
                expander_expanded = '',
                expander_highlight = 'NeoTreeExpander'
            },
            icon = {
                folder_closed = '',
                folder_open = '',
                folder_empty = 'ﰊ',
                default = '*'
            },
            modified = {symbol = '[+]', highlight = 'NeoTreeModified'},
            name = {trailing_slash = false, use_git_status_colors = true},
            git_status = {
                symbols = {
                    -- Change type
                    added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
                    deleted = '✖', -- this can only be used in the git_status source
                    renamed = '', -- this can only be used in the git_status source
                    -- Status type
                    untracked = '',
                    ignored = '',
                    unstaged = '',
                    staged = '',
                    conflict = ''
                }
            }
        },
        window = {
            mappings = {
                ['<bs>'] = 'close_node',
                ['<cr>'] = 'open',
                ['s'] = 'open_split',
                ['v'] = 'open_vsplit',
                ['t'] = 'open_tabnew',
                ['C'] = 'noop',
                ['a'] = 'add',
                ['A'] = 'add_directory',
                ['d'] = 'delete',
                ['r'] = 'rename',
                ['y'] = 'copy_to_clipboard',
                ['x'] = 'cut_to_clipboard',
                ['p'] = 'paste_from_clipboard',
                ['c'] = 'copy', -- takes text input for destination
                ['m'] = 'move', -- takes text input for destination
                ['q'] = 'close_window',
                ['R'] = 'refresh',
                ['z'] = 'noop'
            }
        },
        nesting_rules = {},
        filesystem = {
            filtered_items = {
                visible = false, -- when true, they will just be displayed differently than normal items
                hide_dotfiles = false,
                hide_gitignored = true,
                hide_by_name = {
                    '.DS_Store',
                    'thumbs.db'
                    -- "node_modules"
                },
                never_show = { -- remains hidden even if visible is toggled to true
                    -- ".DS_Store",
                    -- "thumbs.db"
                }
            },
            follow_current_file = false, -- This will find and focus the file in the active buffer every
            -- time the current file is changed while the tree is open.
            hijack_netrw_behavior = 'disabled', -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
            -- instead of relying on nvim autocmd events.
            window = {
                popup = {
                    position = {col = '100%', row = '2'},
                    size = function(state)
                        local root_name = vim.fn.fnamemodify(state.path, ':~')
                        local root_len = string.len(root_name) + 4
                        return {
                            width = math.max(root_len, 50),
                            height = vim.o.lines - 6
                        }
                    end
                },
                mappings = {
                    --  ['<bs>'] = 'navigate_up',
                    ['.'] = 'set_root',
                    ['H'] = 'toggle_hidden',
                    --  ['/'] = 'fuzzy_finder',
                    ['/'] = 'noop',
                    ['f'] = 'filter_on_submit',
                    ['<c-x>'] = 'clear_filter'
                }
            }
        },
        buffers = {},
        git_status = {}
    })

    --  g.nvim_tree_side = 'left'
    --  g.nvim_tree_width = 30
    --  --  g.nvim_tree_quit_on_open = 1
    --  g.nvim_tree_indent_markers = 1
    --  g.nvim_tree_git_hl = 1
    --  g.nvim_tree_allow_resize = 1
    --  g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1}
    --  g.nvim_tree_icons = {
    --  default = '',
    --  symlink = '',
    --  git = {
    --  unstaged = '✗',
    --  staged = '✓',
    --  unmerged = '',
    --  renamed = '➜',
    --  untracked = '★'
    --  },
    --  folder = {default = '', open = ''}
    --  }
    --  require'nvim-tree'.setup {
    --  auto_close = true,
    --  view = {width = 50, side = 'right'},
    --  actions = {
    --  open_file = {quit_on_open = true}
    --  }
    --  }
end
