return function()
    require("telescope").setup({})
    local horizontalLayoutConfig =
        "layout_strategy='horizontal',layout_config={width=0.9, height=0.9, mirror=false, preview_width=0.6}"
    local verticalLayoutConfig = "layout_strategy='vertical',layout_config={width=0.9, height=0.9}"

    map("n", "gf", "<CMD>lua require('telescope.builtin').git_files({" .. horizontalLayoutConfig .. "})<CR>")
    map(
        "n",
        "gF",
        "<CMD>lua require('telescope.builtin').find_files({hidden=true,no_ignore=true," ..
            horizontalLayoutConfig .. "})<CR>"
    )

    map("n", "gc", "<CMD>lua require('telescope.builtin').live_grep({" .. verticalLayoutConfig .. "})<CR>")
    map(
        "n",
        "gC",
        "<CMD>lua require('telescope.builtin').live_grep({additional_args=function(options) return {'--hidden', '--no-ignore'} end," ..
            verticalLayoutConfig .. "})<CR>"
    )

    map("n", "go", "<CMD>lua require('telescope.builtin').grep_string({" .. verticalLayoutConfig .. "})<CR>")
    map(
        "n",
        "gO",
        "<CMD>lua require('telescope.builtin').grep_string({additional_args=function(options) return {'--hidden', '--no-ignore'} end," ..
            verticalLayoutConfig .. "})<CR>"
    )

    map(
        "n",
        "gb",
        "<CMD>lua require('telescope.builtin').buffers({sort_lastused=true," .. horizontalLayoutConfig .. "})<CR>"
    )

    map("n", "gr", "<CMD>lua require('telescope.builtin').resume()<CR>")
end
