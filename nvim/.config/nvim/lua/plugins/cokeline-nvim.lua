return function()
    local get_hex = require("cokeline/utils").get_hex
    local space = {text = " "}
    require("cokeline").setup(
        {
            cycle_prev_next_mappings = true,
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
                        return buffer.filename
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
