local mason_packages_to_install = {}

local install_packages_delay_timeout = 500
vim.defer_fn(function()
  require("mason").setup()
  local registry = require("mason-registry")
  registry.refresh(function()
    for _, name in pairs(mason_packages_to_install) do
      if registry.has_package(name) and not registry.is_installed(name) then
        registry.get_package(name):install()
      end
    end
  end)
end, install_packages_delay_timeout)

return {
  install_mason_packages = function(names)
    for _, name in pairs(names) do
      table.insert(mason_packages_to_install, name)
    end
  end,

  get_path = function(target, paths)
    local current = target
    for i, path in pairs(paths) do
      current = current[path]
    end
    return current
  end,
  string = {
    rep = function(str, count)
      local acc = ""
      for _ = 1, count do
        acc = acc .. str
      end
      return acc
    end,
  },
  t = {
    keys = vim.tbl_keys,
    merge = vim.tbl_deep_extend,
    len = vim.tbl_count,
    includes = vim.tbl_contains,
    filter = vim.tbl_filter,
    find = function(predicate, tbl)
      return vim.tbl_filter(predicate, tbl)[1]
    end,
  },
  hi = vim.api.nvim_set_hl,
}
