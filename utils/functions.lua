Util = Util or {}

function Util.get_1D_table_length(array)
    local count = 0
    for _, o in pairs(array) do
        if o ~= nil and o ~= "" then count = count + 1 end
    end
    return count
end