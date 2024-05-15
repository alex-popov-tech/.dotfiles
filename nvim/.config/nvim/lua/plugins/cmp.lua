local function fillSpacesToFixed(str, untilLength)
  local untilFixed = untilLength - string.len(str)
  local postfix = ""
  for i = 1, untilFixed, 1 do
    postfix = postfix .. " "
  end
  return str .. postfix
end

local format = function(entry, vim_item)
  local menuMapping = {
    buffer = "|buf|",
    path = "|pth|",
    nvim_lua = "|vim|",
    nvim_lsp = "|lsp|",
    luasnip = "|snp|",
    codeium = "|cdm|",
    copilot = "|cpt|",
  }
  local prettySourceName = menuMapping[entry.source.name]

  if prettySourceName == nil then
    -- text buff like git commit or so
    vim_item.menu = prettySourceName
  else
    -- buffers with code mostly
    vim_item.menu = "|" .. fillSpacesToFixed(vim_item.kind, 8) .. prettySourceName
  end

  vim_item.kind = require("lspkind").symbolic(vim_item.kind, { with_text = false })
  return vim_item
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- 'octaltree/cmp-look',
      -- 'hrsh7th/cmp-emoji',
      "onsails/lspkind-nvim",
      "jcha0713/cmp-tw2css",
      {
        "Exafunction/codeium.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Codeium",
        build = ":Codeium Auth",
        opts = { enable_chat = true },
      },
      {
        "MattiasMTS/cmp-dbee",
        dependencies = { "kndndrj/nvim-dbee" },
        ft = "sql", -- optional but good to have
        opts = {}, -- needed
      },
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = cmp.config.sources({
          { name = "codeium" },
          { name = "cmp-dbee" },
          { name = "nvim_lsp" },
          { name = "cmp-tw2css" },
          -- {name = 'luasnip'},
          { name = "buffer" },
          { name = "path" },
        }),
        completion = { completeopt = "menu,menuone,noinsert" },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = format,
        },
        window = {
          completion = {
            border = {
              "╭",
              "─",
              "╮",
              "│",
              "╯",
              "─",
              "╰",
              "│",
            },
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
            scrollbar = "║",
          },
          documentation = {
            border = {
              "─",
              "─",
              "╮",
              "│",
              "╯",
              "─",
              "─",
              "→",
            },
          },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-CR>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        experimental = { ghost_text = { hl_group = "LspCodeLens" } },
      })

      cmp.setup.filetype("lua", {
        sources = {
          {
            name = "nvim_lua",
            trigger_characters = { "." },
            max_item_count = 20,
          },
        },
      })

      -- cmp.setup.filetype({'gitcommit', 'markdown', 'octo'}, {
      --     sources = {{name = 'look', keyword_length = 4, max_item_count = 10}}
      -- })
      -- cmp.setup.filetype({'octo', 'markdown'},
      --                    {sources = cmp.config.sources({{name = 'emoji'}})})
    end,
  },
}
