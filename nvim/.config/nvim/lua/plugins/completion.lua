return {
  "saghen/blink.cmp",
  dependencies = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" },
  event = "InsertEnter",
  version = "v0.*",
  opts = {
    keymap = {
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },

      ["<C-e>"] = { "cancel", "fallback" },

      ["<C-CR>"] = { "accept", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    },
    sources = {
      completion = {
        enabled_providers = { "lsp", "path", "buffer", "lazydev" },
      },
      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lsp = { fallback_for = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      },
    },
  },
}
