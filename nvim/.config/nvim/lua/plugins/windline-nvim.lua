return function()
    local windline = require("windline")
    local b_components = require("windline.components.basic")
    local lsp_comps = require("windline.components.lsp")

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
                            text = function(_, _, width)
                                local result = ""

                                if vim.bo.readonly then
                                    result = result .. "🔒"
                                end

                                result = result .. vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")

                                local color = "green"
                                if vim.bo.modified then
                                    color = "yellow"
                                end

                                return {
                                    {result, {color, "bg"}}
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
