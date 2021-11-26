return function()
    g.startify_lists = {{type = "dir", header = {" Most recently updated in " .. fn.getcwd()}}}
    -- use vsc root when enter file
    g.startify_change_to_vcs_root = 1
    -- do not show 'edit' and 'quit' options
    g.startify_enable_special = 1
    -- start from 1 when choosing
    g.startify_custom_indices = {"a", "r", "e", "t", "o", "s", "i", "n"}
end
