return function()
    local finders = require "telescope.builtin"
    local telescope = require "telescope"
    local sorters = require "telescope.sorters"
    local previewers = require "telescope.previewers"

    telescope.setup {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--hidden",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
            },
            -- prompt_position = "top",
            -- prompt_prefix = " ❯",
            file_ignore_patterns = {".git/*", "node_modules"},
            path_display = { 'shorten' },
            color_devicons = true,
            winblend = 20,
            file_sorter = sorters.get_fzy_sorter,
            generic_sorter = sorters.get_fzy_sorter,
            file_previewer = previewers.vim_buffer_cat.new,
            grep_previewer = previewers.vim_buffer_vimgrep.new,
            qflist_previewer = previewers.vim_buffer_qflist.new
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = true,
                override_file_sorter = true
            },
            fzf_writer = {
                minimum_grep_characters = 2,
                minimum_files_characters = 2,
                -- Disabled by default.
                -- Will probably slow down some aspects of the sorter, but can make color highlights.
                -- I will work on this more later.
                use_highlighter = true
            }
        }
    }
    require("telescope").load_extension("fzy_native")

    function TelescopeOpen(fn)
        finders[fn](require("telescope.themes").get_dropdown({previewer = false}))
    end

    function TelescopeOpenPrewiev(fn)
        finders[fn](require("telescope.themes").get_dropdown({}))
    end

    map("n", "gf", "<CMD>lua TelescopeOpenPrewiev('git_files')<CR>")
    map("n", "gF", "<CMD>lua TelescopeOpenPrewiev('find_files')<CR>")
    map("n", "gb", "<CMD>lua TelescopeOpenPrewiev('buffers')<CR>")
    cmd("cnoreabbrev comm lua TelescopeOpen('commands')")
    map("n", "go", "<CMD>lua TelescopeOpenPrewiev('grep_string')<CR>")
    map(
        "n",
        "gc",
        "<CMD>lua require('telescope').extensions.fzf_writer.grep(require'telescope.themes'.get_dropdown({}))<CR>"
    )
    map("n", "gbr", "<CMD>lua TelescopeOpenPrewiev('git_branches')<CR>")
    map("n", "'D", "<CMD>lua TelescopeOpenPrewiev('lsp.document_diagnostics')<cr>", {noremap = true, silent = true})
    map("n", "ga", ":Telescope tmux pane_contents")
end
