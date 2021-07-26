return function()
    local colors = {
        spaceBg = "none",
        spaceFg = "none",
        modeBg = "none",
        modeFg = "#9ecd6f",
        fileiconBg = "none",
        filepathBg = "none",
        filepathFg = "#e5c463",
        errorBg = "none",
        errorFg = "#fc5d7c",
        warningBg = "none",
        warningFg = "#e7c664",
        hintBg = "none",
        hintFg = "#7f8490",
        infoBg = "none",
        infoFg = "#7f8490",
        gitBg = "none",
        gitFg = "#78dce8",
        lineBg = "none",
        lineFg = "#78dce8"
    }

    local gl = require("galaxyline")
    local gls = gl.section
    gl.short_line_list = {
        "LuaTree",
        "vista",
        "dbui",
        "startify",
        "term",
        "nerdtree",
        "fugitive",
        "fugitiveblame",
        "plug"
    }

    local space = {
        Space = {
            provider = function()
                return " "
            end,
            highlight = {colors.spaceFg, colors.spaceBg}
        }
    }

    local buffer_not_empty = function()
        if fn.empty(vim.fn.expand("%:t")) ~= 1 then
            return true
        end
        return false
    end

    local wide_enough = function()
        local squeeze_width = vim.fn.winwidth(0)
        if squeeze_width > 80 then
            return true
        end
        return false
    end

    gls.left = {
        {
            ViMode = {
                provider = function()
                    local aliases = {
                        ["n"] = "NORMAL",
                        ["i"] = "INSERT",
                        ["c"] = "COMMAND",
                        ["V"] = "VISUAL"
                    }
                    return aliases[vim.fn.mode()]
                end,
                highlight = {colors.modeFg, colors.modeBg}
            }
        },
        space,
        {
            FileIcon = {
                provider = "FileIcon",
                highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.fileiconBg}
            }
        },
        {
            FilePath = {
                provider = function()
                    -- return vim.fn.expand("%:F")
                    local result = ""
                    if vim.bo.readonly then
                        result = result .. "🔒"
                    end
                    if wide_enough() then
                        result = result .. vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")
                    else
                        result = result .. vim.fn.expand "%:t"
                    end
                    if vim.bo.modified then
                        result = result .. " 🖍"
                    end
                    return result
                end,
                condition = buffer_not_empty,
                highlight = {colors.filepathFg, colors.filepathBg}
            }
        }
    }
    gls.mid = {}

    gls.right = {
        {
            DiagnosticError = {
                provider = "DiagnosticError",
                icon = " ",
                highlight = {colors.errorFg, colors.errorBg}
            }
        },
        {
            DiagnosticWarn = {
                provider = "DiagnosticWarn",
                icon = " ",
                highlight = {colors.warningFg, colors.warningBg}
            }
        },
        {
            DiagnosticHint = {
                provider = "DiagnosticHint",
                icon = " ",
                highlight = {colors.hintFg, colors.hintBg}
            }
        },
        {
            DiagnosticInfo = {
                provider = "DiagnosticInfo",
                icon = " ",
                highlight = {colors.hintFg, colors.hintBg}
            }
        },
        {
            GitIcon = {
                provider = function()
                    return " "
                end,
                condition = require("galaxyline.provider_vcs").check_git_workspace,
                highlight = {colors.gitFg, colors.gitBg}
            }
        },
        {
            GitBranch = {
                provider = "GitBranch",
                condition = require("galaxyline.provider_vcs").check_git_workspace,
                highlight = {colors.gitFg, colors.gitBg, "bold"}
            }
        }
    }
end
