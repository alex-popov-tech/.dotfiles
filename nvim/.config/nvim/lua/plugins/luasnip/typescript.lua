local ls = require('luasnip')
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local types = require('luasnip.util.types')
local conds = require('luasnip.extras.expand_conditions')
local events = require('luasnip.util.events')
local ai = require('luasnip.nodes.absolute_indexer')
local fmt = require('luasnip.extras.fmt').fmt
local extras = require('luasnip.extras')
local postfix = require('luasnip.extras.postfix').postfix

ls.add_snippets('typescript', {
  postfix('.if', fmt([[
if ({}) {{
    {}
}}
]] , { l(l.POSTFIX_MATCH), i(1) })),
  postfix('.debug', {
    l('console.log(`\x1b[7m==>`,' .. l.POSTFIX_MATCH .. ', `<==\x1b[0m`);')
  }),
  s('a', { t('await ') }),
  s('as', { t('async ') }),
  s('r', { t('return ') })
})

