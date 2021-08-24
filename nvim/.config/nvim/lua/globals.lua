_G.includes = function(map, expected)
    for _, value in pairs(map) do
        if expected == value then
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

function _G.map(mode, key, result, opts)
    opts =
        vim.tbl_extend(
        "keep",
        opts or {},
        {
            noremap = true,
            silent = true,
            expr = false
        }
    )
    vim.api.nvim_set_keymap(mode, key, result, opts)
end

function _G.au(event, filetype, action)
    vim.cmd("au " .. " " .. event .. " " .. filetype .. " " .. action)
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

    vim.lsp.buf.formatting_seq_sync(nil, 500, nil)
    vim.cmd("w | :e | TSBufEnable highlight")
end

_G.g = vim.g
_G.cmd = vim.cmd
_G.fn = vim.fn
_G.lsp = vim.lsp
