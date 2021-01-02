return function()
    local nord_colors = {
        bg = "#2E3440",
        fg = "#81A1C1",
        line_bg = "#2E3440",
        fg_green = "#8FBCBB",
        yellow = "#EBCB8B",
        cyan = "#A3BE8C",
        darkblue = "#81A1C1",
        green = "#8FBCBB",
        orange = "#D08770",
        purple = "#B48EAD",
        magenta = "#BF616A",
        gray = "#616E88",
        blue = "#5E81AC",
        red = "#BF616A"
    }

    local gl = require("galaxyline")
    local gls = gl.section
    gl.short_line_list = {"LuaTree", "vista", "dbui"}

    local space = {
        Space = {
            provider = function()
                return " "
            end
        }
    }

    local buffer_not_empty = function()
        if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
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
                highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color}
            }
        },
        {
            FileName = {
                provider = function()
                    return vim.fn.expand("%:F")
                end,
                condition = buffer_not_empty
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
                highlight = {nord_colors.red, nord_colors.line_bg}
            }
        },
        {
            DiagnosticWarn = {
                provider = function()
                    return diagnostic_count("warn")
                end,
                icon = " ",
                condition = any_diagnostic("warn"),
                highlight = {nord_colors.yellow, nord_colors.line_bg}
            }
        },
        {
            DiagnosticHint = {
                provider = function()
                    return diagnostic_count("hint")
                end,
                icon = " ",
                condition = any_diagnostic("hint"),
                highlight = {nord_colors.blue, nord_colors.line_bg}
            }
        },
        {
            DiagnosticInfo = {
                provider = function()
                    return diagnostic_count("info")
                end,
                icon = " ",
                condition = any_diagnostic("info"),
                highlight = {nord_colors.gray, nord_colors.line_bg}
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
                highlight = {nord_colors.red, nord_colors.line_bg}
            }
        },
        {
            GitBranch = {
                provider = "GitBranch",
                condition = require("galaxyline.provider_vcs").check_git_workspace
            }
        },
        {
            LineInfo = {
                provider = "LineColumn"
            }
        },
        space
    }
end
