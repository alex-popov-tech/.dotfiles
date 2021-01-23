return function()
    local telescope = require "telescope"
    local sorters = require "telescope.sorters"
    local previewers = require "telescope.previewers"
    telescope.setup {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--no-ignore",
                "--hidden",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
            },
            prompt_position = "top",
            prompt_prefix = " ❯",
            file_ignore_patterns = {".git", "node_modules"},
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new
        }
    }
    -- map("n", "gf", ":lua require'telescope.builtin'.git_files()<cr>")
    -- map(
        -- "n",
        -- "gF",
        -- ":lua require'telescope.builtin'.find_files({ find_command = { 'fd', '--hidden', '--no-ignore' }})<cr>"
    -- )
    map("n", "go", ":lua require'telescope.builtin'.grep_string()<cr>")
    -- map("n", "gC", ":lua require'telescope.builtin'.live_grep()<cr>")
end
