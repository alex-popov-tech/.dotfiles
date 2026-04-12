-- LuaSnip — snippet engine used by blink.cmp.
local defer = require("defer")
-- deferred to next event loop tick. by the time a user actually triggers
-- a snippet, the schedule callback has long since run.

-- PackChanged hook: build optional jsregexp module on install/update.
-- MUST be registered before vim.pack.add() for install hooks to fire.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name ~= "LuaSnip" then
      return
    end
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
      return
    end
    vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path })
  end,
})

defer.later(function()
  vim.pack.add({
    { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") },
  })

  -- load vscode-style snippets from friendly-snippets (and any other source)
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

  -- global snippets (all filetypes)
  ls.add_snippets("all", {
    s("t", t("true")),
    s("f", t("false")),
    s("r", t("return")),
  })

  -- javascript / typescript shared snippets
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

  -- octo (github pr review) snippets
  ls.add_snippets("octo", {
    s("g", { t(":large_green_circle:") }),
    s("r", { t(":red_circle:") }),
    s("o", { t(":large_orange_circle:") }),
  })
end)
