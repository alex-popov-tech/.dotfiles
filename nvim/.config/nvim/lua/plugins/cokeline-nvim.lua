return function()
    local get_hex = require("cokeline/utils").get_hex
    local space = {text = " "}
    local isNonEmptyString = function(str)
        return str ~= nil and str ~= ""
    end
    require("cokeline").setup(
        {
            cycle_prev_next_mappings = true,
            buffers = {
                -- A function to filter out unwanted buffers. It takes the `buffer` table
                -- (described above) as a parameter.
                -- For example, if you want to keep terminals out of your cokeline:
                --   filter = function(buffer) return buffer.type ~= 'terminal' end,
                filter = function(buffer)
                    return isNonEmptyString(buffer.type) and isNonEmptyString(buffer.filetype) and
                        isNonEmptyString(buffer.path) and
                        isNonEmptyString(buffer.filename)
                end
            },
            default_hl = {
                focused = {
                    bg = "none"
                },
                unfocused = {
                    fg = get_hex("Comment", "fg"),
                    bg = "none"
                }
            },
            components = {
                space,
                {
                    text = function(buffer)
                        return buffer.devicon.icon
                    end,
                    hl = {
                        fg = function(buffer)
                            return buffer.devicon.color
                        end
                    }
                },
                {
                    text = function(buffer)
                        return buffer.unique_prefix .. buffer.filename
                    end,
                    hl = {
                        fg = function(buffer)
                            if buffer.is_focused then
                                return "#78dce8"
                            end
                            if buffer.is_modified then
                                return "#e5c463"
                            end
                        end,
                        style = function(buffer)
                            if buffer.is_focused then
                                return "underline"
                            end
                            return nil
                        end
                    }
                },
                {
                    text = function(buffer)
                        if buffer.is_readonly then
                            return " 🔒"
                        end
                        return ""
                    end
                },
                space
            }
        }
    )
    -- map("n", "<S-Up>", "<Cmd>lua require'cokeline'.focus({ step = 1 })<CR>")
    -- map("n", "<S-Down>", "<Cmd>lua require'cokeline'.focus({ step = -1 })<CR>")
    cmd("nmap <S-Up> <Plug>(cokeline-focus-next)")
    cmd("nmap <S-Down> <Plug>(cokeline-focus-prev)")
    hi("tablinefill", {guibg = "none"})
end
