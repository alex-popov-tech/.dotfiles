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
    sorting = {
      comparators = {
        cmp.config.compare.length,
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.order
      }
    },
    sources = {
      { name = 'nvim_lsp', keyword_length = 1, max_item_count = 20 },
      { name = 'buffer', keyword_length = 2, max_item_count = 10 },
      { name = 'path', priority = 1 }
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
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
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
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
      -- ['<CR>'] = cmp.mapping(function(fallback)
      --   if not cmp.confirm({ select = false }) then
      --     require('pairs.enter').type()
      --   else
      --     fallback()
      --   end
      -- end),
      --
    }
  })
  cmp.event:on('confirm_done', function(event)
    local item = event.entry:get_completion_item()
    local parensDisabled = item.data and item.data.funcParensDisabled or
        false
    if not parensDisabled and
        (item.kind == kind.Method or item.kind == kind.Function) then
      require('pairs.bracket').type_left('(')
    end
  end)
  cmp.setup.cmdline('/', {
    completion = { completeopt = 'menu,menuone,noinsert,noselect' },
    sources = { { name = 'fuzzy_buffer' } }
  })
  cmp.setup.filetype('octo', {
    sources = cmp.config.sources({
      { name = 'emoji' } -- You can specify the `cmp_git` source if you were installed it.
    })
  })

  au('filetype', 'lua',
    'lua require"cmp".setup.buffer({ sources = {' .. '{ name = "nvim_lua" },' ..
    '{ name = "nvim_lsp", trigger_characters = {"."}, max_item_count = 20 }' ..
    '}})')
  au('filetype', 'gitcommit,markdown',
    'lua require"cmp".setup.buffer { sources = { ' ..
    '{ name = "look", keyword_length = 5, max_item_count = 10 }' ..
    ' } }')
  vim.cmd [[
      " gray
      highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
      " blue
      highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
      highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
      " light blue
      highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
      highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
      highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
      " pink
      highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
      highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
      " front
      highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
      highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
      highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
    ]]
end
