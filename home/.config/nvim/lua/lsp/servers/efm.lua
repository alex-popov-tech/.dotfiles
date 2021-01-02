return function(config)
    config.efm.setup {
    default_config = {
      cmd = {
        "efm-langserver",
        "-c",
        [["$HOME/.config/efm-langserver/config.yaml"]]
      }
    },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescript.tsx",
      "typescriptreact",
      "lua"
    }
  }
end
