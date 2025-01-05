return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  opts = {
    completion = {
      list = {
        selection = "manual",
      },
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
      documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "single" } },
    },
    sources = {
      default = { "lsp", "path", "buffer", "lazydev" },
      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
      cmdline = {},
    },
    signature = { window = { border = "single" } },
    keymap = {
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },

      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },

      ["<C-e>"] = { "cancel", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    },
  },
  opts_extend = { "sources.default" },
}
