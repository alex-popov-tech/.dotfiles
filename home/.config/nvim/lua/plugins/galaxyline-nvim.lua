return function()
    local colors = {
        spaceBg = "#2c2e34",
        spaceFg = "#2c2e34",
        fileiconBg = "#2c2e34",
        fileiconFg = require("galaxyline.provider_fileinfo").get_file_icon_color,
        filepathBg = "#2c2e34",
        filepathFg = "#85d3f2",
        errorBg = "#2c2e34",
        errorFg = "#fc5d7c",
        warningBg = "#2c2e34",
        warningFg = "#e7c664",
        hintBg = "#2c2e34",
        hintFg = "#7f8490",
        infoBg = "#2c2e34",
        infoFg = "#7f8490",
        giticonBg = "#2c2e34",
        giticonFg = "#fc5d7c",
        gitbranchBg = "#343136",
        gitbranchFg = "#e2e2e3"
    }

    local gl = require("galaxyline")
    local gls = gl.section
gl.short_line_list = {
    'LuaTree',
    'vista',
    'dbui',
    'startify',
    'term',
    'nerdtree',
    'fugitive',
    'fugitiveblame',
    'plug'
}

    local space = {
        Space = {
            provider = function()
                return " "
            end,
            highlight = {colors.spaceFg, colors.spaceBg}
        }
    }

    local kek = {
        kek = {
            provider = function()
                return "kek"
            end,
            -- highlight = {colors.spaceFg, colors.spaceBg}
        }
    }

    local buffer_not_empty = function()
        if fn.empty(vim.fn.expand("%:t")) ~= 1 then
            return true
        end
        return false
    end

    local diagnostic_count = function(type)
        return require("galaxyline.provider_diagnostic")["get_diagnostic_" .. type]()
    end

    local any_diagnostic = function(type)
        return function()
            return diagnostic_count(type) ~= 0
        end
    end

    gls.left = {
        {
            FileIcon = {
                provider = "FileIcon",
                highlight = {colors.fileiconFg, colors.fileiconBg}
            }
        },
        {
            FileName = {
                provider = function()
                    return vim.fn.expand("%:F")
                end,
                condition = buffer_not_empty,
                highlight = {colors.filepathFg, colors.filepathBg}
            }
        },
        space,
        {
            DiagnosticError = {
                provider = function()
                    return diagnostic_count("error")
                end,
                icon = " ",
                condition = any_diagnostic("error"),
                highlight = {colors.errorFg, colors.errorBg}
            }
        },
        {
            DiagnosticWarn = {
                provider = function()
                    return diagnostic_count("warn")
                end,
                icon = " ",
                condition = any_diagnostic("warn"),
                highlight = {colors.warningFg, colors.warningBg}
            }
        },
        {
            DiagnosticHint = {
                provider = function()
                    return diagnostic_count("hint")
                end,
                icon = " ",
                condition = any_diagnostic("hint"),
                highlight = {colors.hintFg, colors.hintBg}
            }
        },
        {
            DiagnosticInfo = {
                provider = function()
                    return diagnostic_count("info")
                end,
                icon = " ",
                condition = any_diagnostic("info"),
                highlight = {colors.hintFg, colors.hintBg}
            }
        }
    }

    gls.right = {
        {
            GitIcon = {
                provider = function()
                    return " "
                end,
                condition = require("galaxyline.provider_vcs").check_git_workspace,
                highlight = {colors.giticonFg, colors.giticonBg}
            }
        },
        {
            GitBranch = {
                provider = "GitBranch",
                condition = require("galaxyline.provider_vcs").check_git_workspace,
                highlight = {colors.gitbranchFg, colors.gitbranchBg}
            }
        },
        space,
    }
end
