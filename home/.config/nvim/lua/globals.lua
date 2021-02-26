_G.range = function(from, to)
    local result = {}
    for i = from, to do
        result[i] = i
    end
    return result
end

_G.installLsp = function()
    -- https://github.com/mattn/vim-lsp-settings should be installed
    -- and that set to download in single dir   vim.g.lsp_settings_servers_dir = vim.fn.stdpath("cache") .. "/lspconfig"
    vim.cmd [[set filetype=typescript]]
    vim.cmd [[LspInstallServer typescript-language-server]]
    vim.cmd [[set filetype=lua]]
    vim.cmd [[LspInstallServer sumneko-lua-language-server]]
    vim.cmd [[set filetype=python]]
    vim.cmd [[LspInstallServer pyls]]
    vim.cmd [[set filetype=sh]]
    vim.cmd [[LspInstallServer bash-language-server]]
    vim.cmd [[set filetype=json]]
    vim.cmd [[LspInstallServer json-languageserver]]
    vim.cmd [[set filetype=yaml]]
    vim.cmd [[LspInstallServer yaml-language-server]]
    vim.cmd [[set filetype="*"]]
    vim.cmd [[LspInstallServer efm-langserver]]
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

_G.g = vim.g
_G.cmd = vim.cmd
_G.fn = vim.fn
_G.lsp = vim.lsp
