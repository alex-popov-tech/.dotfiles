return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  opts = {
    keymap = {
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },

      ["<C-e>"] = { "cancel", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    },
    sources = {
      default = { "lsp", "path", "buffer", "snippets", "lazydev" },
      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        border = "single",
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 100, window = { border = "single" } },
    },
    snippets = { preset = "luasnip" },
    signature = { enabled = true, window = { border = "single" } },
    cmdline = { enabled = true, completion = { menu = { auto_show = false } } },
  },
  opts_extend = { "sources.default" },
}
