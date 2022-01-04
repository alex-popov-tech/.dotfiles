_G.includes = function(map, expected)
    for _, value in pairs(map) do
        if expected == value then
          return true
        end
    end
    return false
end

_G.keyIncludes = function(map, expected)
    for key, _ in pairs(map) do
        if expected == key then
          return true
        end
    end
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
    for i = from, to do
        result[i] = i
    end
    return result
end

_G.printt = function(tbl)
    print(vim.inspect(tbl))
end

_G.reload = function()
    local modules = {"lsp", "plugins", "globals", "mappings", "settings", "ui"}
    for _, moduleName in pairs(modules) do
        for packageName, _ in pairs(package.loaded) do
            if string.find(packageName, "^" .. moduleName) then
                package.loaded[packageName] = nil
            end
        end
        require(moduleName)
    end
end

function _G.map(mode, lhs, rhs, opts)

    local finalRhs = ''
    local callback = nil
    if type(rhs) == 'string' then
      finalRhs = rhs
    else
      callback = rhs
    end

    opts =
        vim.tbl_extend(
        "keep",
        opts or {},
        {
            noremap = true,
            silent = true,
            expr = false,
            callback = callback
        }
    )

    vim.api.nvim_set_keymap(mode, lhs, finalRhs, opts)
end

function _G.merge(dest, source, strategy)
  return vim.tbl_extend(strategy or 'keep', source or {}, dest)
end

function _G.au(event, filetype, action)
    vim.cmd("au" .. " " .. event .. " " .. filetype .. " " .. action)
end

function _G.hi(group, options)
    vim.cmd(
        "hi " ..
            group ..
                " " ..
                    "cterm=" ..
                        (options.cterm or "none") ..
                            " " ..
                                "ctermfg=" ..
                                    (options.ctermfg or "none") ..
                                        " " ..
                                            "ctermbg=" ..
                                                (options.ctermbg or "none") ..
                                                    " " ..
                                                        "gui=" ..
                                                            (options.gui or "none") ..
                                                                " " ..
                                                                    "guifg=" ..
                                                                        (options.guifg or "none") ..
                                                                            " " .. "guibg=" .. (options.guibg or "none")
    )
end

function _G.ft()
    return vim.api.nvim_buf_get_option(0, "filetype")
end

function _G.fmt()
    if ft() == "json" then
        vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
        return
    end

    if ft() == "typescript" then
        require "nvim-lsp-ts-utils".organize_imports_sync()
    end

    vim.lsp.buf.formatting_seq_sync()
    -- vim.cmd("w | :e | TSBufEnable highlight | :e")
    -- vim.cmd("TSBufEnable highlight")
end

function _G.isNonEmptyString(str)
   if str == nil then
       return false
   end
   if str == "" then
       return false
   end
   return true
end

function _G.addCommand(name, func, opts)
  vim.api.nvim_add_user_command(name, func, opts or {})
end


_G.g = vim.g
_G.cmd = vim.cmd
_G.fn = vim.fn
_G.lsp = vim.lsp
