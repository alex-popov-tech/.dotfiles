return function(config)
	local bin_path = vim.fn.stdpath("cache") .. "/lspconfig/efm-langserver/efm-langserver"
    config.efm.setup {
    default_config = {
      cmd = {
        bin_path,
        "-c",
        [[/Users/alexanderpopov/.config/efm-langserver/config.yaml]]
      }
    },
    filetypes = {
      "javascript",
      "typescript",
      "lua"
    }
  }
end
