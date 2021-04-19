return function()
    vim.g.gitblame_enabled = 0
    require "timer".add(
        function()
            require("gitblame").show_blame_info()
            return 5000
        end
    )
end
