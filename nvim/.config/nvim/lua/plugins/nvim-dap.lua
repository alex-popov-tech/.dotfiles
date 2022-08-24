return function()
  local dap = require('dap')
  vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

  vim.keymap.set('n', '<leader>c', function() dap.continue() end)
  vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
  vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
  vim.keymap.set('n', '<leader>b', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
  -- require'dap.ui.widgets'.hover()
end
