local util = require("util")

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      -- {
      --   "igorlfs/nvim-dap-view",
      --   opts = {
      --     windows = {
      --       terminal = {
      --         -- List of debug adapters for which the terminal should be ALWAYS hidden
      --         hide = { "go" },
      --       },
      --     },
      --   },
      -- },
    },
    event = "VeryLazy",
    init = function()
      -- util.install_mason_packages({ "delve" })
      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
    end,
    config = function()
      local dap = require("dap")
      -- local dapview = require("dap-view")
      -- dapview.setup()
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
      dap.listeners.before.attach.dapui_config = function()
        -- dapview.open()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        -- dapview.open()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        -- dapview.close()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        -- dapview.close()
        dapui.close()
      end
      require("dap-go").setup()
    end,
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
      },
      {
        "<leader>dd",
        function()
          require("dap").terminate()
        end,
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
      },
      {
        "<leader>dB",
        function()
          vim.ui.input({ prompt = "Expression for conditional endpoint" }, function(input)
            if input ~= "" then
              require("dap").toggle_breakpoint(input)
            else
              require("dap").toggle_breakpoint()
            end
          end)
        end,
      },
      {
        "<leader>dn",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
      },
    },
  },
}
