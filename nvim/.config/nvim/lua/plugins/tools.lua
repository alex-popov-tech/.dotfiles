return {
  {
    "SuperBo/fugit2.nvim",
    opts = { width = "80%", height = "80%" },
    cmd = { "Fugit2", "Fugit2Graph" },
    keys = { { "<leader>F", mode = "n", "<cmd>Fugit2<cr>" } },
    init = function()
      vim.cmd("cnoreabbrev git Fugit2")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      {
        -- optional: for diffview.nvim integration
        "sindrets/diffview.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- lazy, only load diffview by these commands
        cmd = {
          "DiffviewFileHistory",
          "DiffviewOpen",
          "DiffviewToggleFiles",
          "DiffviewFocusFiles",
          "DiffviewRefresh",
        },
      },
      {
        "chrisgrieser/nvim-tinygit", -- optional: for Github PR view
        dependencies = { "stevearc/dressing.nvim" },
      },
    },
  },

  {
    "kndndrj/nvim-dbee",
    cmd = { "Dbee" },
    dependencies = { "MunifTanjim/nui.nvim" },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    init = function()
      vim.cmd("cnoreabbrev db Dbee")
    end,
    config = function()
      require("dbee").setup( --[[optional config]])
    end,
  },

  -- open terminal in floating window
  {
    "numToStr/FTerm.nvim",
    config = function()
      require("FTerm").setup({
        border = "rounded",
        dimensions = { height = 0.99, width = 0.99 },
      })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end,
    keys = {
      {
        "<F11>",
        function()
          require("FTerm").toggle()
        end,
        mode = { "t", "n" },
      },
    },
  },

  -- global replace
  {
    "windwp/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
    cmd = "Replace",
    config = function()
      require("spectre").setup({
        color_devicons = true,
        line_sep_start = "┌-----------------------------------------",
        result_padding = "¦  ",
        line_sep = "└-----------------------------------------",
        highlight = {
          ui = "String",
          search = "DiffDelete",
          replace = "DiffChange",
        },
      })
      vim.api.nvim_create_user_command("Replace", function()
        require("spectre").open()
      end, {})
    end,
  },

  -- screenkey logging
  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    version = "*",
    config = true,
  },

  -- screen code snippets
  {
    "mistricky/codesnap.nvim",
    cmd = { "Screen", "Take", "TakeScreen" },
    build = "make",
    config = function()
      local codesnap = require("codesnap")
      for _, name in ipairs({ "Screen", "Take", "TakeScreen" }) do
        vim.api.nvim_create_user_command(name, function()
          codesnap.copy_into_clipboard()
        end, { nargs = "*", range = "%" })
      end
    end,
  },

}
