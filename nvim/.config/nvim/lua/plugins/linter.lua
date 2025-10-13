local util = require("util")

local linters_by_ft = {
  markdown = {
    "typos",
  },
  html = {
    "markuplint",
    "typos",
  },
  yaml = {
    "yamllint",
    "typos",
  },
  css = {
    "stylelint",
    "typos",
  },
  templ = {
    "markuplint",
  },
  dotenv = {
    "dotenv_linter",
    "typos",
  },
  javascript = {
    "eslint_d",
    "typos",
  },
  typescript = {
    "eslint_d",
    "typos",
  },
  go = {
    "golangcilint",
    "typos",
  },
}

local linterFts = vim.tbl_keys(linters_by_ft)
local linters = { "golangci-lint" }

for ft, lintersTable in pairs(linters_by_ft) do
  for _, linter in pairs(lintersTable) do
    table.insert(linters, linter)
  end
end

return {
  {
    "mfussenegger/nvim-lint",
    dependencies = { { "williamboman/mason.nvim", lazy = true } },
    ft = linterFts,
    config = function()
      local nvimLint = require("lint")

      util.install_mason_packages(linters)

      nvimLint.linters_by_ft = linters_by_ft

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("my-nvim-lint", { clear = true }),
        callback = function()
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          nvimLint.try_lint()
        end,
      })
    end,
  },
}
