-- Deep copy function for tables
table.copy = function(obj)
    if type(obj) ~= "table" then
        error("Input must be a table")
    end

    local res = {}
    for k, v in pairs(obj) do
        if type(v) == "table" then
            res[k] = table.copy(v)
        else
            res[k] = v
        end
    end
    return res
end

