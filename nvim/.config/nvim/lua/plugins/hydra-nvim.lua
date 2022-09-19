return function()
  local Hydra = require('hydra')
  Hydra({
    name = 'DEBUG mode',
    hint = [[
    s/c - start/continue
    t - terminate
    e - eval
    n - step over
    i - step into
    o - step out
    b - toggle breakpoint
    B - toggle conditional breakpoint
    lb - toggle log breakpoint
    rt - run closest test (go)
    esc - exit
        ]],
    config = {
      hint = { position = 'bottom', border = 'rounded' },
      timeout = 6000
    },
    invoke_on_body = true,
    mode = 'n',
    body = '<leader>d',
    heads = {
      { 'c', function()
        require 'dap'.continue()
      end },
      { 's', function()
        require 'dap'.continue()
      end },
      { 't', function()
        require 'dap'.terminate()
      end },
      { 'e', function()
        require 'dapui'.eval(vim.fn.input('Evaluate: '))
      end },
      { 'n', function()
        require'dap'.step_over()
      end },
      { 'i', function()
        require'dap'.step_into()
      end },
      { 'o', function()
        require'dap'.step_out()
      end },
      { 'b', function()
        require'dap'.toggle_breakpoint()
      end },
      { 'B', function()
        require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end },
      { 'lb', function()
        require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
      end },
      { 'rt', function()
        require('dap-go').debug_test()
      end },
      { '<esc>', nil, exit = true }
    }
  })
end
