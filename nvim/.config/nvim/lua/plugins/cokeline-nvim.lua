return function()
    local colors = require('catppuccin.palettes').get_palette()
    colors.bg = colors.base

    local get_hex = require('cokeline/utils').get_hex
    local space = {text = ' '}
    require('cokeline').setup({
        mappings = {cycle_prev_next = true},
        buffers = {
            -- A function to filter out unwanted buffers. It takes the `buffer` table
            -- (described above) as a parameter.
            -- For example, if you want to keep terminals out of your cokeline:
            --   filter = function(buffer) return buffer.type ~= 'terminal' end,
            filter_valid = function(buffer)
                return isNonEmptyString(buffer.path) and
                           isNonEmptyString(buffer.filename)
            end
        },
        default_hl = {
            bg = colors.bg,
            fg = function(buffer)
                if not buffer.is_focused then
                    return get_hex('Comment', 'fg')
                end
            end
        },
        components = {
            space,
            {
                text = function(buffer)
                    return buffer.devicon.icon
                end,
                fg = function(buffer) return buffer.devicon.color end
            },
            {
                text = function(buffer)
                    return buffer.unique_prefix .. buffer.filename
                end,
                fg = function(buffer)
                    if buffer.is_focused then
                        return colors.mauve
                    end
                    if buffer.is_modified then
                        return colors.yellow
                    end
                    return get_hex('Comment', 'fg')
                end,
                style = function(buffer)
                    if buffer.is_focused then
                        return 'italic'
                    end
                    return nil
                end
            },
            {
                text = function(buffer)
                    if buffer.is_readonly then return ' 🔒' end
                    return ''
                end
            },
            space
        }
    })
    cmd('nmap <S-Up> <Plug>(cokeline-focus-next)')
    cmd('nmap <S-Down> <Plug>(cokeline-focus-prev)')
    hi('tablinefill', {guibg = 'none'})
end
