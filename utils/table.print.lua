-- @4: obj, mode, max_depth, visited
table.print = function(...)
    local args = {...}
    local obj = args[1]
    local mode = args[2] or "v"
    local max_depth = args[3] or 10
    local visited = args[4] or {}

    if type(obj) ~= "table" then
        error("First argument must be a table")
    end

    local function print_table_recursive(current_obj, current_depth, current_visited)
        if current_depth >= max_depth then
            print("<maximum depth reached>")
            return
        end

        if current_visited[current_obj] then
            print("<circular reference detected>")
            return
        end

        current_visited[current_obj] = true

        -- Process all elements in a single loop
        local function process_element(k, v)
            -- Define behavior based on value type and mode
            local behaviors = {
                k = { table_func = function() print(tostring(k)) end, non_table_func = function() print(tostring(k)) end },
                v = { table_func = function() print_table_recursive(v, current_depth + 1, current_visited) end, non_table_func = function() print(tostring(v)) end },
                kv = { table_func = function() print(tostring(k) .. ":"); print_table_recursive(v, current_depth + 1, current_visited) end, non_table_func = function() print(tostring(k) .. ": " .. tostring(v)) end }
            }

            local behavior = behaviors[mode] or behaviors.kv
            local value_type = type(v) == "table" and "table_func" or "non_table_func"
            behavior[value_type]()
        end

        -- Process all keys using ipairs for array part and a manual approach for hash part
        -- Array part: indices 1 to #current_obj
        for i = 1, #current_obj do
            process_element(i, current_obj[i])
        end

        -- Note: Accessing hash keys in Lua tables requires some form of iteration
        -- Using rawget with known keys would require knowing keys in advance
        -- The following is the most direct way to access non-array keys without pairs
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
                process_element(k, v)
            end
        until map_key == nil

        current_visited[current_obj] = nil
    end

    print_table_recursive(obj, 0, visited)
end