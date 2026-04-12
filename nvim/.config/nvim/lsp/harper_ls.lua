return {
  settings = {
    ["harper-ls"] = {
      userDictPath = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
      diagnosticSeverity = "hint", -- error|hint|information|warning
    },
  },
}
