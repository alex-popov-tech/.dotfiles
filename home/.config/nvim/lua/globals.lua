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

_G.fmt = function()
    return vim.lsp.buf.formatting_sync(nil, 500)
end

_G.reload = function()
    local modules = {"lsp", "plugins", "globals", "mappings", "settings", "ui", "utils"}
    for _, moduleName in pairs(modules) do
        for packageName, _ in pairs(package.loaded) do
            if string.find(packageName, "^" .. moduleName) then
                package.loaded[packageName] = nil
            end
        end
        require(moduleName)
    end
end
