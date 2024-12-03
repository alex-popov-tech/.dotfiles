local util = require("util")

local formatters_by_ft = {
  go = { "gofmt", "golines", "goimports-reviser" },
  templ = { "templ" },
  sql = { "sql_formatter" },
  lua = { "stylua" },
  yaml = { "yamlfmt" },
  json = { "prettierd" },
  css = { "prettierd" },
  html = { "prettierd" },
  javascript = { "prettierd" },
  typescript = { "prettierd" },
  javascriptreact = { "prettierd" },
  typescriptreact = { "prettierd" },
}

local formatters = {}

for ft, formattersTable in pairs(formatters_by_ft) do
  for _, formatter in pairs(formattersTable) do
    table.insert(formatters, formatter)
  end
end

return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  dependencies = { { "williamboman/mason.nvim", lazy = true } },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format()
      end,
      mode = { "n" },
    },
  },
  opts = {
    formatters_by_ft = formatters_by_ft,
  },
  init = function()
    util.install_mason_packages(formatters)
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
