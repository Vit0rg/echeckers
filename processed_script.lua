
-- /home/s1eep1ess/workspace/lua/echeckers/settings/configuration.lua
BUILD = 'TUI'
MODE = 'basic'
UI = {}
math.randomseed(os.time())
-- /home/s1eep1ess/workspace/lua/echeckers/settings/modes/basic.lua
LIFE = 2000
BIOMATTER = 3
MAX_BIOMATTER = 10
MAX_TURNS = 5
DECK_SIZE = 10
HAND_SIZE = 4
HAND_LIMIT = DECK_SIZE/2
SCALE = 100
-- /home/s1eep1ess/workspace/lua/echeckers/settings/player_options.lua

-- /home/s1eep1ess/workspace/lua/echeckers/utils/string/string.center.lua
-- Center text within given visual width (emoji = 2 chars)
string.center = function(s, width)
    -- Convert numbers to strings
    s = tostring(s)
    -- Remove trailing space if present (for emoji padding)
    local trimmed = s:gsub(' $', '')

    local vlen = 0
    local i = 1
    while i <= #trimmed do
        local b1 = string.byte(trimmed, i)
        if b1 < 128 then
            vlen = vlen + 1
            i = i + 1
        elseif b1 < 192 then
            i = i + 1
        else
            local char_bytes
            if b1 >= 240 then char_bytes = 4
            elseif b1 >= 224 then char_bytes = 3
            elseif b1 >= 192 then char_bytes = 2
            else char_bytes = 1 end
            -- Skip variation selector
            local next_i = i + char_bytes
            if next_i + 2 <= #trimmed then
                local b2, b3 = string.byte(trimmed, next_i, next_i + 1)
                if b2 == 239 and b3 == 184 then
                    local b4 = string.byte(trimmed, next_i + 2)
                    if b4 >= 128 and b4 <= 143 then
                        next_i = next_i + 3
                    end
                end
            end
            i = next_i
            vlen = vlen + 2
        end
    end

    local pad = width - vlen
    if pad < 0 then pad = 0 end
    local left_pad = math.ceil(pad / 2)
    local right_pad = pad - left_pad
    return string.rep(' ', left_pad) .. trimmed .. string.rep(' ', right_pad)
end

-- /home/s1eep1ess/workspace/lua/echeckers/utils/string/string.split.lua
string.split = function(value, sep, f)
	if sep == nil or sep == "" then
		-- If no separator is provided, return each character
		local out = {}
		for i = 1, #value do
			out[i] = value:sub(i, i)
		end
		return out
	end

	local out = {}
	local index = 1

	-- Handle empty string case
	if value == "" then
		return {""}
	end

	-- Process the string by finding separators iteratively without a while loop
	local remaining_value = value
	local start_pos = 1

	-- Since we need to avoid while loops, we'll use a for loop with a large upper bound
	-- and break when no more separators are found
	for _ = 1, #value do
		local pos = string.find(remaining_value, sep, start_pos, true) -- plain text search
		if not pos then
			-- No more separators, add the rest of the string
			local chunk = string.sub(remaining_value, start_pos)
			out[index] = (f and type(f) == "function" and f(chunk) or chunk)
			break
		else
			-- Add the substring before the separator
			local chunk = string.sub(remaining_value, start_pos, pos - 1)
			out[index] = (f and type(f) == "function" and f(chunk) or chunk)
			index = index + 1
			start_pos = pos + #sep
			remaining_value = value
		end
	end

	return out
end
-- /home/s1eep1ess/workspace/lua/echeckers/utils/string/char_width.lua
--- Calculate the visual width of a string
--- Emojis with variation selector = 1 char width, emojis without = 2 char width
---@param s string
---@return integer visual_width
string.char_width = function(s)
    local vlen = 0
    local i = 1
    while i <= #s do
        local b1 = string.byte(s, i)
        if b1 < 128 then
            vlen = vlen + 1
            i = i + 1
        elseif b1 < 192 then
            i = i + 1
        else
            local char_bytes
            if b1 >= 240 then char_bytes = 4
            elseif b1 >= 224 then char_bytes = 3
            elseif b1 >= 192 then char_bytes = 2
            else char_bytes = 1 end
            
            local next_i = i + char_bytes
            local has_variation_selector = false
            
            -- Check for variation selector (U+FE0E or U+FE0F)
            if next_i + 2 <= #s then
                local b2, b3 = string.byte(s, next_i, next_i + 1)
                if b2 == 239 and b3 == 184 then
                    local b4 = string.byte(s, next_i + 2)
                    if b4 >= 128 and b4 <= 143 then
                        next_i = next_i + 3
                        has_variation_selector = true
                    end
                end
            end
            
            i = next_i
            -- Emoji with variation selector = 1 visual char, without = 2 visual chars
            vlen = vlen + (has_variation_selector and 1 or 2)
        end
    end
    return vlen
end

-- /home/s1eep1ess/workspace/lua/echeckers/utils/string/string.replace.lua
string.replace = function (str, target, replacement, count)
    count = count or 1
    local escaped_target = string.gsub(target, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
    local escaped_replacement = string.gsub(replacement, "%%", "%%%%")
    if count <= 0 then
        return string.gsub(str, escaped_target, escaped_replacement)
    end
    return string.gsub(str, escaped_target, escaped_replacement, count)
end
-- /home/s1eep1ess/workspace/lua/echeckers/utils/table/table.print.lua
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

    -- Process all keys using ipairs for array part and a manual approach for hash part
    -- Array part: indices 1 to #current_obj
    for i = 1, #current_obj do
        output = _process_element(i, current_obj[i], mode, separator, _print_table_recursive, current_depth, current_visited, output, max_depth)
        if separator ~= "" then
            output = output .. separator
        end
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

-- /home/s1eep1ess/workspace/lua/echeckers/utils/table/table.copy.lua
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


-- /home/s1eep1ess/workspace/lua/echeckers/utils/table/table.unpack.lua
-- By default, i is 1 and j is #list.
table.unpack = table.unpack or function (list, i, j)
     i = i or 1
     j = j or #list

     return unpack(list, i, j)
end
-- /home/s1eep1ess/workspace/lua/echeckers/ui/main_menu.lua
local _TUI_update_menu = function (output)
    print(output)
end

UI.update_menu = function (output)
    if BUILD == 'TUI' then
        _TUI_update_menu(output)
    end
end

-- /home/s1eep1ess/workspace/lua/echeckers/menus/main_menu.lua
--Main Entry points for other folders
local new_game = function ()
    --entry point for mode menu
    print('new_game')
end

local settings = function ()
    --entry point to configuration files
    --entry point to userdata
    print('settings')
end

local credits = function ()
    print('credits')
    --entry point to Credits
end

local exit = function ()
    --save data
    --display messages
    print('exit')
    os.exit()
end

local main_menu = function ()
    local options = {'New Game', 'Settings', 'Credits', 'Exit'}
    local actions = {new_game, settings, credits, exit}
    local output = string.format("\nEcheckers\n\n%s\n%s\n%s\n%s\n",
                            options[1], options[2], options[3], options[4])

    -- UI.update_menu(output)

    -- implement input here
    local input = 1
    actions[input]()
end

main_menu()
-- /home/s1eep1ess/workspace/lua/echeckers/events/chatCommand.lua

-- /home/s1eep1ess/workspace/lua/echeckers/events/keyboard.lua

-- /home/s1eep1ess/workspace/lua/echeckers/events/loop.lua

-- /home/s1eep1ess/workspace/lua/echeckers/events/newPlayer.lua

-- /home/s1eep1ess/workspace/lua/echeckers/events/playerLeft.lua

-- /home/s1eep1ess/workspace/lua/echeckers/events/textAreaCallback.lua

-- /home/s1eep1ess/workspace/lua/echeckers/src/init.lua
-- init function

--[[ 
    start game ->
        0 = Setup
        1 = Draw phase
        2 = Standby phase
            Move and set
        3 = Battle Phase
            Battle step
            Damage step
        4 = End phase
    ]]
-- /home/s1eep1ess/workspace/lua/echeckers/src/main.lua
-- main script

