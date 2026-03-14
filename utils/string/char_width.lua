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
