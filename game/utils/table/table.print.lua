local function _process_element(k, v, mode, separator, _print_table_recursive_fn, current_depth, current_visited, output, max_depth)
    -- Define behavior based on value type and mode
    local behaviors = {
        k = { table_func = function() output = output .. tostring(k) end, non_table_func = function() output = output .. tostring(k) end },
        v = { table_func = function() output = _print_table_recursive_fn(v, current_depth + 1, current_visited, mode, separator, max_depth, output) end, non_table_func = function() output = output .. tostring(v) end },
        kv = { table_func = function() output = output .. tostring(k) .. ":"; output = _print_table_recursive_fn(v, current_depth + 1, current_visited, mode, separator, max_depth, output) end, non_table_func = function() output = output .. tostring(k) .. ": " .. tostring(v) end }
    }

    local behavior = behaviors[mode] or behaviors.kv
    local value_type = type(v) == "table" and "table_func" or "non_table_func"
    behavior[value_type]()
    return output
end

local function _print_table_recursive(current_obj, current_depth, current_visited, mode, separator, max_depth, output)
    if current_depth >= max_depth then
        return output .. "<maximum depth reached>"
    end

    if current_visited[current_obj] then
        return output .. "<circular reference detected>"
    end

    current_visited[current_obj] = true

    -- Process all keys using C-based loop for array part and next() for hash part
    -- Array part: indices 1 to #current_obj
    for i = 1, #current_obj do
        output = _process_element(i, current_obj[i], mode, separator, _print_table_recursive, current_depth, current_visited, output, max_depth)
        if separator ~= "" then
            output = output .. separator
        end
    end

    -- Note: Accessing hash keys in Lua tables requires some form of iteration
    -- Using rawget with known keys would require knowing keys in advance
    -- The following uses next() to access non-array keys without pairs()
    local key_map = {}

    -- Use next to collect all keys first
    local iter_key = nil
    repeat
        local k, v = next(current_obj, iter_key)
        iter_key = k
        if k ~= nil then
            local is_array_index = type(k) == "number" and k >= 1
                                    and k <= #current_obj and math.floor(k) == k
            if not is_array_index then
                key_map[k] = v  -- Store only non-array keys
            end
        end
    until iter_key == nil

    -- Then process only non-array keys using next
    local map_key = nil
    repeat
        local k, v = next(key_map, map_key)
        map_key = k
        if k ~= nil then
            output = _process_element(k, v, mode, separator, _print_table_recursive, current_depth, current_visited, output, max_depth)
            if separator ~= "" then
                output = output .. separator
            end
        end
    until map_key == nil

    current_visited[current_obj] = nil
    return output
end

-- @5: obj, mode, max_depth, visited, separator
table.print = function(...)
    local args = {...}
    local obj = args[1]
    local mode = args[2] or "v"
    local max_depth = args[3] or 10
    local visited = args[4] or {}
    local separator = args[5] or ""

    if type(obj) ~= "table" then
        error("First argument must be a table")
    end

    local output = ""

    output = _print_table_recursive(obj, 0, visited, mode, separator, max_depth, output)

    print(output)
end
