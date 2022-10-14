_G.vim = vim
_G.g = vim.g
_G.cmd = vim.cmd
_G.fn = vim.fn
_G.lsp = vim.lsp

_G.includes = function(map, expected)
    for _, value in pairs(map) do if expected == value then return true end end
    return false
end

_G.keyIncludes = function(map, expected)
    for key, _ in pairs(map) do if expected == key then return true end end
    return false
end

_G.keys = function(map)
    local result = {}
    local index = 1
    for key, _ in pairs(map) do
        result[index] = key
        index = index + 1
    end
    return result
end

_G.range = function(from, to)
    local result = {}
    for i = from, to do result[i] = i end
    return result
end

_G.printt = function(tbl) print(vim.inspect(tbl)) end

function _G.map(mode, lhs, rhs, opts)

    local finalRhs = ''
    local callback = nil
    if type(rhs) == 'string' then
        finalRhs = rhs
    else
        callback = rhs
    end

    opts = vim.tbl_extend('keep', opts or {}, {
        noremap = true,
        silent = true,
        expr = false,
        callback = callback
    })

    vim.api.nvim_set_keymap(mode, lhs, finalRhs, opts)
end

function _G.merge(dest, source, strategy)
    return vim.tbl_extend(strategy or 'keep', source or {}, dest)
end

function _G.au(event, filetype, action)
    vim.cmd('au' .. ' ' .. event .. ' ' .. filetype .. ' ' .. action)
end

function _G.hi(group, options)
    --  vim.cmd("hi " .. group .. " " .. "cterm=" .. (options.cterm or "none") ..
    --  " " .. "ctermfg=" .. (options.ctermfg or "none") .. " " ..
    --  "ctermbg=" .. (options.ctermbg or "none") .. " " .. "gui=" ..
    --  (options.gui or "none") .. " " .. "guifg=" ..
    --  (options.guifg or "none") .. " " .. "guibg=" ..
    --  (options.guibg or "none"))
    local style = options.style and 'gui=' .. options.style or 'gui=NONE'
    local fg = options.fg and 'guifg=' .. options.fg or 'guifg=NONE'
    local bg = options.bg and 'guibg=' .. options.bg or 'guibg=NONE'
    local sp = options.sp and 'guisp=' .. options.sp or ''
    local blend = options.blend and 'blend=' .. options.blend or ''
    local hl =
        'highlight ' .. group .. ' ' .. style .. ' ' .. fg .. ' ' .. bg .. ' ' ..
            sp .. ' ' .. blend
    vim.cmd(hl)
end

function _G.ft() return vim.api.nvim_buf_get_option(0, 'filetype') end

function _G.isNonEmptyString(str)
    if str == nil then return false end
    if str == '' then return false end
    return true
end

function _G.sleep(sec) vim.cmd('sleep ' .. sec) end

function _G.addCommand(name, func, opts)
    vim.api.nvim_create_user_command(name, func, opts or {})
function _G.run(command, opts)
  local output = ""
  local notification
  local notify = function(msg, level)
    local notify_opts = vim.tbl_extend(
      "keep",
      opts or {},
      { title = table.concat(command, " "), replace = notification }
    )
    notification = vim.notify(msg, level, notify_opts)
  end
  local on_data = function(_, data)
    output = output .. table.concat(data, "\n")
  end
  vim.fn.jobstart(command, {
    on_stdout = on_data,
    on_stderr = on_data,
    on_exit = function(_, code)
      if #output == 0 then
        notify("No output of command, exit code: " .. code, "warn")
      else
        notify(output, "info")
      end
    end,
  })
end

