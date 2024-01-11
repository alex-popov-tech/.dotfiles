-- define line number hl for lines with Lsp errors
vim.cmd [[sign define DiagnosticSignWarn text= texthl= numhl=DiagnosticSignWarn linehl=]]
vim.cmd [[sign define DiagnosticSignError text= texthl= numhl=DiagnosticSignError linehl=]]
vim.fn.sign_define('DiagnosticSignError', {
    text = '',
    texthl = '',
    linehl = '',
    numhl = 'DiagnosticSignError'
})
vim.fn.sign_define('DiagnosticSignWarn', {
    text = '',
    texthl = '',
    linehl = '',
    numhl = 'DiagnosticSignWarn'
})

-- set global diagnostic config
vim.diagnostic.config({
    signs = true,
    underline = true,
    virtual_text = {prefix = '<'},
    float = {scope = 'line', border = 'rounded', focusable = false},
    severity_sort = true
})

local md_namespace = vim.api.nvim_create_namespace 'alex_popov_tech/lsp_float'

local methods = vim.lsp.protocol.Methods
---LSP handler that adds extra inline highlights, keymaps, and window options.
---Code inspired from `noice`.
---@param handler fun(err: any, result: any, ctx: any, config: any): integer, integer
---@return function
local function enhanced_float_handler(handler)
    return function(err, result, ctx, config)
        local buf, win = handler(err, result, ctx,
                                 vim.tbl_deep_extend('force', config or {}, {
            border = 'rounded',
            max_height = math.floor(vim.o.lines * 0.5),
            max_width = math.floor(vim.o.columns * 0.4)
        }))

        if not buf or not win then return end

        -- Conceal everything.
        vim.wo[win].concealcursor = 'n'

        -- Extra highlights.
        for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
            for pattern, hl_group in pairs {
                ['|%S-|'] = '@text.reference',
                ['@%S+'] = '@parameter',
                ['^%s*(Parameters:)'] = '@text.title',
                ['^%s*(Return:)'] = '@text.title',
                ['^%s*(See also:)'] = '@text.title',
                ['{%S-}'] = '@parameter'
            } do
                local from = 1 ---@type integer?
                while from do
                    local to
                    from, to = line:find(pattern, from)
                    if from then
                        vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1,
                                                     from - 1, {
                            end_col = to,
                            hl_group = hl_group
                        })
                    end
                    from = to and to + 1 or nil
                end
            end
        end

        -- Add keymaps for opening links.
        if not vim.b[buf].markdown_keys then
            vim.keymap.set('n', 'K', function()
                -- Vim help links.
                local url =
                    (vim.fn.expand '<cWORD>' --[[@as string]] ):match '|(%S-)|'
                if url then return vim.cmd.help(url) end

                -- Markdown links.
                local col = vim.api.nvim_win_get_cursor(0)[2] + 1
                local from, to
                from, to, url =
                    vim.api.nvim_get_current_line():find '%[.-%]%((%S-)%)'
                if from and col >= from and col <= to then
                    vim.system({'open', url}, nil, function(res)
                        if res.code ~= 0 then
                            vim.notify('Failed to open URL' .. url,
                                       vim.log.levels.ERROR)
                        end
                    end)
                end
            end, {buffer = buf, silent = true})
            vim.b[buf].markdown_keys = true
        end
    end
end

vim.lsp.handlers[methods.textDocument_hover] =
    enhanced_float_handler(vim.lsp.handlers.hover)
vim.lsp.handlers[methods.textDocument_signatureHelp] =
    enhanced_float_handler(vim.lsp.handlers.signature_help)
-- vim.lsp.handlers['textDocument/signatureHelp'] =
--     vim.lsp.with(vim.lsp.handlers.signature_help,
--                  {border = 'rounded', focusable = false})

-- table from lsp severity to vim severity.
local severity = {
    'error',
    'warn',
    'info',
    'info' -- map both hint and info to info?
}
vim.lsp.handlers['window/showMessage'] =
    function(err, method, params, client_id)
        vim.notify(method.message, severity[params.type])
    end

-- Utility functions shared between progress reports for LSP and DAP

local client_notifs = {}

local function get_notif_data(client_id, token)
    if not client_notifs[client_id] then client_notifs[client_id] = {} end

    if not client_notifs[client_id][token] then
        client_notifs[client_id][token] = {}
    end

    return client_notifs[client_id][token]
end

local spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'}

local function update_spinner(client_id, token)
    local notif_data = get_notif_data(client_id, token)

    if notif_data.spinner then
        local new_spinner = (notif_data.spinner + 1) % #spinner_frames
        notif_data.spinner = new_spinner

        notif_data.notification = vim.notify(nil, nil, {
            hide_from_history = true,
            icon = spinner_frames[new_spinner],
            replace = notif_data.notification
        })

        vim.defer_fn(function() update_spinner(client_id, token) end, 100)
    end
end

local function format_title(title, client_name)
    return client_name .. (#title > 0 and ': ' .. title or '')
end

local function format_message(message, percentage)
    return (percentage and percentage .. '%\t' or '') .. (message or '')
end

vim.lsp.handlers['$/progress'] = function(_, result, ctx)
    local client_id = ctx.client_id

    local val = result.value

    if not val.kind then return end

    local notif_data = get_notif_data(client_id, result.token)

    if val.kind == 'begin' then
        local message = format_message(val.message, val.percentage)

        notif_data.notification = vim.notify(message, 'info', {
            title = format_title(val.title,
                                 vim.lsp.get_client_by_id(client_id).name),
            icon = spinner_frames[1],
            timeout = false,
            hide_from_history = false
        })

        notif_data.spinner = 1
        update_spinner(client_id, result.token)
    elseif val.kind == 'report' and notif_data then
        notif_data.notification = vim.notify(
                                      format_message(val.message, val.percentage),
                                      'info', {
                replace = notif_data.notification,
                hide_from_history = false
            })
    elseif val.kind == 'end' and notif_data then
        notif_data.notification = vim.notify(val.message and
                                                 format_message(val.message) or
                                                 'Complete', 'info', {
            icon = '',
            replace = notif_data.notification,
            timeout = 3000
        })

        notif_data.spinner = nil
    end
end
