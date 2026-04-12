-- nvim-dap — debug adapter protocol client with UI and Go support
local defer = require("defer")

defer.later(function()
  vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/leoluz/nvim-dap-go",
  })

  vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup({
    icons = { expanded = "🞃", collapsed = "🞂", current_frame = "→" },
    controls = {
      icons = {
        pause = "⏸",
        play = "⯈",
        step_into = "↴",
        step_over = "↷",
        step_out = "↑",
        step_back = "↶",
        run_last = "🗘",
        terminate = "🕱",
        disconnect = "⏻",
      },
    },
  })

  -- auto-open/close dap-ui with debug sessions
  dap.listeners.before.attach.dapui_config = function() dapui.open() end
  dap.listeners.before.launch.dapui_config = function() dapui.open() end
  dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
  dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

  -- go debugging via delve
  require("dap-go").setup()

  -- keymaps
  vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Debug: continue" })
  vim.keymap.set("n", "<leader>dd", function() dap.terminate() end, { desc = "Debug: terminate" })
  vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: toggle breakpoint" })
  vim.keymap.set("n", "<leader>dB", function()
    vim.ui.input({ prompt = "Expression for conditional breakpoint" }, function(input)
      if input and input ~= "" then
        dap.toggle_breakpoint(input)
      else
        dap.toggle_breakpoint()
      end
    end)
  end, { desc = "Debug: conditional breakpoint" })
  vim.keymap.set("n", "<leader>dn", function() dap.step_over() end, { desc = "Debug: step over" })
  vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Debug: step into" })
  vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "Debug: step out" })
end)
