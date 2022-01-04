return function()
    -- define line number hl for lines with Lsp errors
    vim.cmd [[sign define DiagnosticSignWarn text= texthl= numhl=DiagnosticSignWarn linehl=]]
    vim.cmd [[sign define DiagnosticSignError text= texthl= numhl=DiagnosticSignError linehl=]]

    -- set global diagnostic config
    vim.diagnostic.config(
        {
            signs = true,
            underline = true,
            virtual_text = { prefix = '<' },
            float = { scope = "line", border = "rounded", focusable = false },
            severity_sort = true,
        }
    )

    -- add borders to some floating things
    vim.lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
      focusable = false,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
      focusable = false,
    })

    vim.lsp.buf.rename = {
      float = function()
        local currName = vim.fn.expand("<cword>")
        local tshl = require("nvim-treesitter-playground.hl-info").get_treesitter_hl()
        if tshl and #tshl > 0 then
          local ind = tshl[#tshl]:match("^.*()%*%*.*%*%*")
          tshl = tshl[#tshl]:sub(ind + 2, -3)
        end

        local win = require('plenary.popup').create(currName, {
          title = "New Name",
          style = "minimal",
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          relative = "cursor",
          borderhighlight = "FloatBorder",
          titlehighlight = "Title",
          highlight = tshl,
          focusable = true,
          width = 25,
          height = 1,
          line = "cursor+2",
          col = "cursor-1"
        })

        local map_opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
        vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('"..currName..","..win.."')<CR>", map_opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('"..currName..","..win.."')<CR>", map_opts)
      end,
      apply = function(curr, win)
        local newName = vim.trim(vim.fn.getline('.'))
        vim.api.nvim_win_close(win, true)
        if #newName > 0 and newName ~= curr then
          local params = vim.lsp.util.make_position_params()
          params.newName = newName
          vim.lsp.buf_request(0, "textDocument/rename", params)
        end
      end
    }
end
