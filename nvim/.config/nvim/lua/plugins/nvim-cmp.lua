return function()
  local cmp = require 'cmp'
  local kind = cmp.lsp.CompletionItemKind
  local lspkind = require('lspkind')

  local function check_back_space()
    local col = fn.col('.') - 1
    return col == 0 or fn.getline('.'):sub(col, col):match('%s') ~= nil
  end

  local function fillSpacesToFixed(str, untilLength)
    local untilFixed = untilLength - string.len(str)
    local postfix = ''
    for i = 1, untilFixed, 1 do postfix = postfix .. ' ' end
    return str .. postfix
  end

  local format = function(entry, vim_item)
    local menuMapping = {
      buffer = '|buf|',
      fuzzy_buffer = '|fbuf|',
      fuzzy_path = '|fpth|',
      path = '|pth|',
      nvim_lua = '|api|',
      nvim_lsp = '|lsp|'
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
      { with_text = false })
    return vim_item
  end

  cmp.setup({
    completion = { completeopt = 'menu,menuone,noinsert' },
    window = {
      completion = {
        border = {
          '╭',
          '─',
          '╮',
          '│',
          '╯',
          '─',
          '╰',
          '│'
        },
        winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
        scrollbar = '║'
      },
      documentation = {
        border = {
          '─',
          '─',
          '╮',
          '│',
          '╯',
          '─',
          '─',
          '→'
        }
      }
    },
    experimental = { native_menu = false, ghost_text = false },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end
    },
    -- sorting = {
    --   comparators = {
    --     cmp.config.compare.length,
    --     cmp.config.compare.offset,
    --     cmp.config.compare.exact,
    --     cmp.config.compare.score,
    --     cmp.config.compare.kind,
    --     cmp.config.compare.sort_text,
    --     cmp.config.compare.order
    --   }
    -- },
    sources = {
      { name = 'nvim_lsp', keyword_length = 1, max_item_count = 20 },
      { name = 'fuzzy_buffer', keyword_length = 2, max_item_count = 10 },
      { name = 'path', priority = 1 }
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = format
    },
    mapping = {
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({
        behavior = cmp.SelectBehavior.Insert
      }), { 'i', 's' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({
        behavior = cmp.SelectBehavior.Insert
      }), { 'i', 's' }),
      ['<Up>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif check_back_space() then
          vim.fn.feedkeys(
            vim.api.nvim_replace_termcodes('<Up>', true, true, true),
            '')
        else
          fallback()
        end
      end,
      ['<Down>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif check_back_space() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Down>',
            true, true,
            true), '')
        else
          fallback()
        end
      end,
      ['<CR>'] = cmp.mapping.confirm({ select = true })
    }
  })

  cmp.setup.filetype({'octo', 'markdown'}, { sources = cmp.config.sources({ { name = 'emoji' } }) })
  cmp.setup.filetype('lua', { sources = {
    { name = "nvim_lua", trigger_characters = { "." }, max_item_count = 20 },
  } })
  cmp.setup.filetype({ 'gitcommit', 'markdown' }, { sources = {
    { name = "look", keyword_length = 4, max_item_count = 10 },
  } })


  hi("CmpItemAbbrDeprecated", { fg = "#808080", bg = "none", style = "strikethrough" })
  hi("CmpItemAbbrDeprecated", { bg = "none", style = "strikethrough", fg = "#808080" })
  hi("CmpItemAbbrMatch", { bg = "none", fg = "#569CD6" })
  hi("CmpItemAbbrMatchFuzzy", { bg = "none", fg = "#569CD6" })

  hi("CmpItemKindVariable", { bg = "none", fg = "#9CDCFE" })
  hi("CmpItemKindInterface", { bg = "none", fg = "#9CDCFE" })
  hi("CmpItemKindText", { bg = "none", fg = "#9CDCFE" })

  hi("CmpItemKindFunction", { bg = "none", fg = "#C586C0" })
  hi("CmpItemKindMethod", { bg = "none", fg = "#C586C0" })

  hi("CmpItemKindKeyword", { bg = "none", fg = "#D4D4D4" })
  hi("CmpItemKindProperty", { bg = "none", fg = "#D4D4D4" })
  hi("CmpItemKindUnit", { bg = "none", fg = "#D4D4D4" })

end
