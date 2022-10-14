return function()
  local tools = require('lsp.servers.nullls')
  require 'mason-tool-installer'.setup {
    ensure_installed = tools.list,
    run_on_start = true,
    start_delay = 2000, -- 3 second delay
  }
end
