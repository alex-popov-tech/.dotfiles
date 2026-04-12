-- nvim-lint — run linters on buffer events
local defer = require("defer")

defer.later(function()
  vim.pack.add({
    "https://github.com/mfussenegger/nvim-lint",
    "https://github.com/williamboman/mason.nvim",
  })

  local linters_by_ft = {
    markdown = { "typos" },
    html = { "markuplint", "typos" },
    yaml = { "yamllint", "typos" },
    css = { "stylelint", "typos" },
    templ = { "markuplint" },
    dotenv = { "dotenv_linter", "typos" },
    javascript = { "eslint_d", "typos" },
    typescript = { "eslint_d", "typos" },
    go = { "golangcilint", "typos" },
  }

  local nvim_lint = require("lint")
  nvim_lint.linters_by_ft = linters_by_ft

  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("user_nvim_lint", { clear = true }),
    callback = function()
      nvim_lint.try_lint()
    end,
  })

  -- :MasonInstallLinters — run once on fresh machines
  vim.api.nvim_create_user_command("MasonInstallLinters", function()
    local tools = {
      "typos",
      "markuplint",
      "yamllint",
      "stylelint",
      "dotenv-linter",
      "eslint_d",
      "golangci-lint",
    }
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs(tools) do
        if registry.has_package(name) and not registry.is_installed(name) then
          registry.get_package(name):install()
        end
      end
    end)
  end, { desc = "Install linters via mason" })
end)
