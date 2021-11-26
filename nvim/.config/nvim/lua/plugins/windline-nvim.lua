return function()
    local windline = require("windline")
    local b_components = require("windline.components.basic")
    local lsp_comps = require("windline.components.lsp")
    local git_comps = require("windline.components.git")

    local space = {
        function()
            return " "
        end
    }
    local divider = {b_components.divider}

    windline.setup(
        {
            colors_name = function(colors)
                local result =
                    vim.tbl_extend(
                    "force",
                    colors,
                    {
                        default_blue = colors.blue,
                        red = "#fc5d7c",
                        green = "#9ecd6f",
                        blue = "#78dce8",
                        yellow = "#e5c463",
                        bg = "none"
                    }
                )
                return result
            end,
            statuslines = {
                {
                    filetypes = {"default"},
                    active = {
                        space,
                        {
                            name = "file",
                            text = function()
                                local readonly_text = ""
                                if vim.bo.readonly then
                                    readonly_text = "🔒 "
                                end

                                local filepath_color = "green"
                                if vim.bo.modified then
                                    filepath_color = "yellow"
                                end

                                local filepath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")
                                local filename = vim.fn.expand("%:t")
                                local fileext = vim.fn.expand("%:e")
                                local icon, color = require "nvim-web-devicons".get_icon_color(filename, fileext)

                                hi("WL_icon_tmp", {guifg = color or "white", guibg = "none"})

                                return {
                                    {icon, "WL_icon_tmp"},
                                    {" "},
                                    {readonly_text .. filepath, {filepath_color, "bg"}}
                                }
                            end
                        },
                        {
                            name = "git",
                            text = function(bufnr)
                                if not git_comps.is_git(bufnr) then
                                    return ""
                                end
                                return {
                                    {git_comps.git_branch({icon = "  "}), {"red", "bg"}},
                                    {" with", {"green", "bg"}},
                                    {git_comps.diff_added({format = "  %s", show_zero = true}), {"green", "bg"}},
                                    {git_comps.diff_removed({format = "  %s", show_zero = true}), {"red", "bg"}},
                                    {git_comps.diff_changed({format = " 柳%s", show_zero = true}), {"blue", "bg"}}
                                }
                            end
                        },
                        divider,
                        {
                            name = "diagnostic",
                            text = function(bufnr)
                                if not lsp_comps.check_lsp(bufnr) then
                                    return {""}
                                end
                                return {
                                    {lsp_comps.lsp_error({format = "  %s", show_zero = true}), {"red", "bg"}},
                                    {lsp_comps.lsp_warning({format = "  %s", show_zero = true}), {"yellow", "bg"}},
                                    {lsp_comps.lsp_hint({format = "  %s", show_zero = true}), {"default_blue", "bg"}}
                                }
                            end
                        },
                        space,
                        {
                            name = "lsp_name",
                            text = function(bufnr)
                                if not lsp_comps.check_lsp(bufnr) then
                                    return ""
                                end
                                return {
                                    {lsp_comps.lsp_name()}
                                }
                            end
                        },
                        space
                    },
                    inactive = {}
                }
            }
        }
    )
    require("wlfloatline").setup(
        {
            interval = 300,
            ui = {
                active_char = "-",
                active_color = "blue",
                active_hl = nil
            },
            skip_filetypes = {
                "NvimTree",
                "lir"
            },
            floating_show_filetypes = {}
        }
    )
end
