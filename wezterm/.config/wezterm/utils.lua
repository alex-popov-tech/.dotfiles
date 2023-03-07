return {
    merge = function(tables)
        local res = {}
        for _, table in pairs(tables) do
            for key, value in pairs(table) do res[key] = value end
        end
        return res
    end,
    find = function(table, predicate)
        for _, val in pairs(table) do
            if predicate(val) then return val end
        end
        return nil
    end,
}
