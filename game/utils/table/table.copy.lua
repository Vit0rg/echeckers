-- Deep copy function for tables
-- Uses C-based loops for arrays, next() for hash tables
table.copy = function(obj, seen)
    seen = seen or {}
    
    if type(obj) ~= "table" then
        return obj
    end
    
    -- Check for circular reference
    if seen[obj] then
        return seen[obj]
    end
    
    local res = {}
    seen[obj] = res
    
    -- Check if table is array-like (sequential numeric keys)
    local is_array = true
    local size = #obj
    if size == 0 then
        -- Empty table or hash table, check for non-numeric keys
        local key = next(obj)
        if key ~= nil and type(key) ~= "number" then
            is_array = false
        end
    end
    
    if is_array and size > 0 then
        -- C-based loop for arrays
        for i = 1, size do
            res[i] = table.copy(obj[i], seen)
        end
    else
        -- Use next() for hash tables (unavoidable for non-sequential keys)
        local key, value = next(obj, nil)
        while key ~= nil do
            res[key] = table.copy(value, seen)
            key, value = next(obj, key)
        end
    end
    
    return res
end

