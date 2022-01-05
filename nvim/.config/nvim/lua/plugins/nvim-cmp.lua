return function()
    local cmp = require "cmp"
    local lspkind = require("lspkind")

    local function check_back_space()
        local col = fn.col(".") - 1
        return col == 0 or fn.getline("."):sub(col, col):match("%s") ~= nil
    end

    local function fillSpacesToFixed(str, untilLength)
        local untilFixed = untilLength - string.len(str)
        local postfix = ""
        for i = 1, untilFixed, 1 do postfix = postfix .. " " end
        return str .. postfix
    end

    cmp.setup({
        completion = {completeopt = "menu,menuone,noinsert"},
        experimental = {native_menu = false, ghost_text = true},
        snippet = {
            expand = function(args)
                -- For `vsnip` user.
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
            end
        },
        formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(entry, vim_item)
                local menuMapping = {
                    buffer = "|buf|",
                    fuzzy_buffer = "|fbuf|",
                    fuzzy_path = "|fpth|",
                    path = "|pth|",
                    nvim_lua = "|api|",
                    nvim_lsp = "|lsp|"
                }
                local prettySourceName = menuMapping[entry.source.name]

                if prettySourceName == nil then
                    -- text buff like git commit or so
                    vim_item.menu = prettySourceName
                else
                    -- buffers with code mostly
                    vim_item.menu = fillSpacesToFixed(vim_item.kind, 8) ..
                                        prettySourceName
                end

                vim_item.kind = lspkind.symbolic(vim_item.kind,
                                                 {with_text = false})
                return vim_item
            end
        },
        sources = {
            {name = "nvim_lsp", max_item_count = 10},
            {name = "buffer", max_item_count = 10},
            -- {name = "fuzzy_buffer", max_item_count = 10},
            {name = "path", priority = 1}
            -- {name = "fuzzy_path", opts = {fd_timeout_msec = 1500}}
        },
        mapping = {
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({
                behavior = cmp.SelectBehavior.Insert
            }), {"i", "s"}),
            ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({
                behavior = cmp.SelectBehavior.Insert
            }), {"i", "s"}),
            ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({
                behavior = cmp.SelectBehavior.Insert
            }), {"i", "s"}),
            ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({
                behavior = cmp.SelectBehavior.Insert
            }), {"i", "s"}),
            ["<CR>"] = cmp.mapping(cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }), {"i", "s"}),
            ["<Tab>"] = function(fallback)
                if vim.fn["vsnip#available"]() == 1 then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                                        "<Plug>(vsnip-expand-or-jump)", true,
                                        true, true), "")
                elseif cmp.visible() then
                    cmp.select_next_item()
                elseif check_back_space() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>",
                                                                   true, true,
                                                                   true), "")
                else
                    fallback()
                end
            end,
            ["<S-Tab>"] = function(fallback)
                if vim.fn["vsnip#available"]() == 1 then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                                        "<Plug>(vsnip-jump-prev)", true, true,
                                        true), "")
                elseif cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end
        }
    })
    cmp.setup.cmdline("/", {
        completion = {completeopt = "menu,menuone,noinsert,noselect"},
        sources = {{name = "fuzzy_buffer"}}
    })

    au("filetype", "lua",
       'lua require"cmp".setup.buffer({ sources = {' .. '{ name = "nvim_lua" },' ..
           '{ name = "nvim_lsp", max_item_count = 20 }' .. "}})")
    au("filetype", "gitcommit,markdown",
       "lua require'cmp'.setup.buffer { sources = { " ..
           "{ name = 'spell', max_item_count = 10 }," ..
           "{ name = 'emoji', max_item_count = 20 }," ..
           "{ name = 'look', max_item_count = 10 }" .. " } }")
end
