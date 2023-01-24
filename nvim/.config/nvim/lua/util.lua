return {
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
      for _=1,count do
        acc = acc .. str
      end
      return acc
    end
  },
  list = {
    concat = vim.list_extend,
    foreach = function(table, consumer)
      for i, val in pairs(table) do
        consumer(val)
      end
    end,
  },
  t = {
    keys = vim.tbl_keys,
    merge = vim.tbl_deep_extend,
    len = vim.tbl_count,
    includes = vim.tbl_contains,
  },
  hi = vim.api.nvim_set_hl,
}
