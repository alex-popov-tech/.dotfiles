return function()
    -- define line number hl for lines with Lsp errors
    vim.cmd [[sign define DiagnosticSignWarn text= texthl= numhl=DiagnosticSignWarn linehl=]]
    vim.cmd [[sign define DiagnosticSignError text= texthl= numhl=DiagnosticSignError linehl=]]

    -- Disable the default signs handler
    vim.diagnostic.config(
        {
            signs = false
        }
    )

    -- Create a namespace. This won't be used to add any diagnostics,
    -- only to display them.
    local ns = vim.api.nvim_create_namespace("my_namespace")

    -- Create a reference to the original function
    local orig_show = vim.diagnostic.show

    local function set_signs(bufnr)
        -- Get all diagnostics from the current buffer
        local diagnostics = vim.diagnostic.get(bufnr)

        -- Find the "worst" diagnostic per line
        local max_severity_per_line = {}
        for _, d in pairs(diagnostics) do
            local m = max_severity_per_line[d.lnum]
            if not m or d.severity < m.severity then
                max_severity_per_line[d.lnum] = d
            end
        end

        -- Show the filtered diagnostics using the custom namespace. Use the
        -- reference to the original function to avoid a loop.
        local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
        orig_show(
            ns,
            bufnr,
            filtered_diagnostics,
            {
                virtual_text = false,
                underline = true,
                signs = true,
                severity_sort = true,
            }
        )
    end

    function vim.diagnostic.show(namespace, bufnr, ...)
        orig_show(namespace, bufnr, ...)
        set_signs(bufnr)
    end

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
