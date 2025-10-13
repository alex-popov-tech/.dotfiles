local util = require("util")
local options = { noremap = true, silent = true }

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = false }),
  callback = function(args)
    local clients = vim.lsp.get_clients()
    local client = util.t.find(function(it)
      return it.id == args.data.client_id
    end, clients)

    vim.lsp.inline_completion.enable()
    vim.diagnostic.config({ signs = function() end })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
    vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, options)
    vim.keymap.set("n", "'gd", vim.lsp.buf.definition, options)
    vim.keymap.set("n", "'rn", vim.lsp.buf.rename, options)

    vim.keymap.set("n", "'gr", function()
      require("fzf-lua").lsp_references()
      -- require("telescope.builtin").lsp_references({
      --   layout_strategy = "vertical",
      --   layout_settings = { width = 0.9, height = 0.9 },
      -- })
    end, options)

    vim.keymap.set("n", "'gi", function()
      if vim.bo.filetype == "go" then
        vim.lsp.buf.definition()
      else
        vim.lsp.buf.implementation()
      end
    end, options)

    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_prev({ float = { border = "single" } })
    end, options)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_next({ float = { border = "single" } })
    end, options)

    vim.keymap.set("n", "'d", function()
      vim.diagnostic.open_float({
        bufnr = 0,
        scope = "line",
        source = true,
        border = "rounded",
      })
    end, options)

    vim.keymap.set("n", "'D", function()
      vim.diagnostic.open_float({
        bufnr = 0,
        scope = "buffer",
        source = true,
        border = "rounded",
      })
    end, options)

    -- vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })

    -- define line number hl for lines with Lsp errors
    local define_sign = function(name)
      vim.fn.sign_define(name, { text = "", texthl = "", linehl = "", numhl = name })
    end

    define_sign("DiagnosticSignError")
    define_sign("DiagnosticSignWarn")
    define_sign("DiagnosticSignHint")
    define_sign("DiagnosticSignInfo")

    -- set colors with delay to apply after lazy nvim loading theme
    function reset_bg_for_highlight(highlight_name)
      local existing_colors = vim.api.nvim_get_hl(0, { name = highlight_name })
      existing_colors.bg = nil
      vim.api.nvim_set_hl(0, highlight_name, existing_colors)
    end

    vim.defer_fn(function()
      reset_bg_for_highlight("DiagnosticSignError")
      reset_bg_for_highlight("DiagnosticSignWarn")
      reset_bg_for_highlight("DiagnosticSignHint")
      reset_bg_for_highlight("DiagnosticSignInfo")
    end, 100)

    -- set global diagnostic config
    vim.diagnostic.config({
      signs = true,
      -- underline = true,
      virtual_text = { prefix = "<- " },
      -- virtual_text = false,
      virtual_lines = false,
      severity_sort = true,
    })
  end,
})
