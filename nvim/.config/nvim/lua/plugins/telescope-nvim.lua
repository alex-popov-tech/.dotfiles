return function()
    require("telescope").setup({})

    local builtin = require 'telescope.builtin'
    local horizontalLayout = {
        layout_strategy = 'horizontal',
        layout_config = {
            width = 0.9,
            height = 0.9,
            mirror = false,
            preview_width = 0.4
        }
    }
    local verticalLayout = {
        layout_strategy = 'vertical',
        layout_config = {width = 0.9, height = 0.9}
    }

    map("n", "gf", function() builtin.git_files(horizontalLayout) end)
    map("n", "gF", function()
        builtin.find_files(merge(horizontalLayout,
                                 {hidden = true, no_ignore = true}))
    end)
    map("n", "gc", function() builtin.live_grep(verticalLayout) end)
    map("n", "gC", function()
        builtin.live_grep(merge(verticalLayout, {
            additional_args = function()
                return {'--hidden', '--no-ignore'}
            end
        }))
    end)
    map("n", "go", function() builtin.grep_string(verticalLayout) end)
    map("n", "gO", function()
        builtin.grep_string(merge(verticalLayout, {
            additional_args = function()
                return {'--hidden', '--no-ignore'}
            end
        }))
    end)
    map("n", "gb", function()
        builtin.buffers(merge(horizontalLayout, {sort_lastused = true}))
    end)
    map("n", "gh", function()
        builtin.oldfiles(merge(horizontalLayout, {cmd_only = true}))
    end)
end
