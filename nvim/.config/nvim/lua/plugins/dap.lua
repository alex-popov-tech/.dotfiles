local util = require("util")

return {
  {
    "mfussenegger/nvim-dap",
    enabled = false,
    dependencies = { { "jay-babu/mason-nvim-dap.nvim", lazy = true }, { "rcarriga/nvim-dap-ui", lazy = true } },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      require("mason-nvim-dap").setup({
        ensure_installed = { "delve" },
        automatic_installation = true,
        automatic_setup = true,
      })
      require("mason-nvim-dap").setup_handlers({})
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
