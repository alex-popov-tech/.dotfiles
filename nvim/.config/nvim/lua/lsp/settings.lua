return function()
    -- define line number hl for lines with Lsp errors
    hi("DiagnosticVirtualTextWarn", {guifg = "#e7c664"})
    hi("DiagnosticVirtualTextError", {guifg = "#fc5d7c"})
    vim.cmd [[sign define DiagnosticSignWarn text= texthl= numhl=DiagnosticSignWarn linehl=]]
    vim.cmd [[sign define DiagnosticSignError text= texthl= numhl=DiagnosticSignError linehl=]]


    -- Disable the default signs handler
    vim.diagnostic.config({signs = false})

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
                underline = false,
                signs = true
            }
        )
    end

    function vim.diagnostic.show(namespace, bufnr, ...)
        orig_show(namespace, bufnr, ...)
        set_signs(bufnr)
    end
end
