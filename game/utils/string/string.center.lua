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
