return function()
    g.completion_items_priority = {
        Field = 10,
        Method = 10,
        Function = 9,
        Variables = 9,
        Constant = 9,
        Interfaces = 8,
        Class = 8,
        Struct = 8,
        Keyword = 8,
        Treesitter = 8,
        TabNine = 8,
        Buffers = 1,
        File = 2
    }
    g.completion_sorting = "length"
    g.completion_matching_strategy_list = {"exact", "substring", "fuzzy", "all"}
    g.completion_matching_smart_case = 1
    g.completion_tabnine_sort_by_details = 1
    g.completion_trigger_character = {".", "::"}
    g.completion_trigger_keyword_length = 2
    g.completion_timer_cycle = 50
    g.completion_customize_lsp_label = {
        Function = " [function]",
        Method = " [method]",
        Reference = " [refrence]",
        Enum = " [enum]",
        Field = "ﰠ [field]",
        Keyword = " [key]",
        Variable = " [variable]",
        Folder = " [folder]",
        Snippet = " [snippet]",
        Operator = " [operator]",
        Module = " [module]",
        Text = "ﮜ [text]",
        Class = " [class]",
        Interface = " [interface]",
        File = " [file]"
    }
    g.completion_enable_snippet = 'vim-vsnip'
    g.completion_enable_auto_signature = 1
end
