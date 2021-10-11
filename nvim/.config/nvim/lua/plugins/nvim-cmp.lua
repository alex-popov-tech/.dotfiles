return function()
    local cmp = require "cmp"
    local types = require "cmp.types"
    local lspkind = require("lspkind")

    local function check_back_space()
        local col = fn.col(".") - 1
        return col == 0 or fn.getline("."):sub(col, col):match("%s") ~= nil
    end

    cmp.setup(
        {
            preselect = types.cmp.PreselectMode.Item,
            completion = {
                completeopt = "menu,menuone,noinsert"
            },
            experimental = {ghost_text = true},
            snippet = {
                expand = function(args)
                    -- For `vsnip` user.
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
                end
            },
            formatting = {
                format = function(entry, vim_item)
                    vim_item.kind = lspkind.presets.default[vim_item.kind]
                    return vim_item
                end
            },
            sources = {
                {name = "vsnip"},
                {name = "nvim_lsp", max_item_count = 20},
                {name = "buffer"},
                {name = "path"}
            },
            mapping = {
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-n>"] = cmp.mapping.select_prev_item(-4),
                ["<C-p>"] = cmp.mapping.select_next_item(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
                ["<Tab>"] = function(fallback)
                    if vim.fn.pumvisible() == 1 then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
                    elseif vim.fn["vsnip#available"]() == 1 then
                        vim.fn.feedkeys(
                            vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true),
                            ""
                        )
                    elseif check_back_space() then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "")
                    else
                        fallback()
                    end
                end,
                ["<S-Tab>"] = function(fallback)
                    if vim.fn.pumvisible() == 1 then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
                    elseif vim.fn["vsnip#available"]() == 1 then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
                    else
                        fallback()
                    end
                end
            }
        }
    )
    au(
        "filetype",
        "gitcommit,markdown",
        "lua require'cmp'.setup.buffer { sources = { " ..
            "{ name = 'spell', max_item_count = 10 }," ..
                "{ name = 'emoji' }," .. "{ name = 'look', max_item_count = 10 }" .. " } }"
    )
end
