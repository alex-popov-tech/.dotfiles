return {
  "L3MON4D3/LuaSnip",
  run = "make install_jsregexp",
  version = "v2.*",
  event = "VeryLazy",
  dependencies = { { "rafamadriz/friendly-snippets", lazy = true } },
  keys = {
    -- {
    --   "<tab>",
    --   function()
    --     if vim.fn["luasnip#expand_or_jumpable"]() then
    --       return "<plug>luasnip-expand-or-jump"
    --     else
    --       return "<tab>"
    --     end
    --   end,
    --   mode = { "s", "i" },
    --   expr = true,
    -- },
    -- {
    --   "<s-tab>",
    --   function()
    --     if vim.fn["luasnip#expand_or_jumpable"]() then
    --       return require("luasnip").jump(-1)
    --     else
    --       return "<s-tab>"
    --     end
    --   end,
    --   mode = { "s", "i" },
    --   expr = true,
    -- },
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local l = require("luasnip.extras").lambda
    local fmt = require("luasnip.extras.fmt").fmt
    local postfix = require("luasnip.extras.postfix").postfix

    local add_postfix = function(trigger, pattern)
      postfix(trigger, fmt(pattern, { l(l.POSTFIX_MATCH), i(1) }))
    end

    ls.add_snippets("all", {
      s("t", t("true")),
      s("f", t("false")),
      s("r", t("return")),
    })

    local js_if_pattern = [[if ({}) {{
                    {}
                }}]]
    local js_snippets = {
      s("c", { t("const") }),
      s("l", { t("let") }),
      s("a", { t("await") }),
      s("as", { t("async") }),
      s("r", { t("return") }),
      add_postfix(".if", js_if_pattern),
      postfix(".debug", {
        l("console.log(`\x1b[7m==>`," .. l.POSTFIX_MATCH .. ", `<==\x1b[0m`);"),
      }),
    }
    ls.add_snippets("javascript", js_snippets)
    ls.add_snippets("typescript", js_snippets)
    ls.add_snippets("javascriptreact", js_snippets)
    ls.add_snippets("typescriptreact", js_snippets)
    ls.add_snippets("octo", {
      s("g", { t(":large_green_circle:") }),
      s("r", { t(":red_circle:") }),
      s("o", { t(":large_orange_circle:") }),
    })
  end,
}
