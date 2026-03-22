--- Convert hex color to RGB values
---@param hex string Hex color string (e.g., '#dddd00' or 'FF551700')
---@return number r, number g, number b
local function hex_to_rgb(hex)
    hex = hex:gsub('^#', '')
    if #hex == 8 then
        hex = hex:sub(3)  -- ARGB format
    end
    local r = tonumber(hex:sub(1, 2), 16) or 0
    local g = tonumber(hex:sub(3, 4), 16) or 0
    local b = tonumber(hex:sub(5, 6), 16) or 0
    return r, g, b
end

--- Convert RGB to ANSI 256-color code
---@param r number Red (0-255)
---@param g number Green (0-255)
---@param b number Blue (0-255)
---@return number ANSI color code (0-255)
local function rgb_to_ansi256(r, g, b)
    local r6 = math.floor((r / 256) * 6)
    local g6 = math.floor((g / 256) * 6)
    local b6 = math.floor((b / 256) * 6)
    return 16 + (r6 * 36) + (g6 * 6) + b6
end

--- Build ANSI escape sequences from color code
---@param color number|string ANSI code (0-255) or hex string
---@return string bg_ansi, string fg_ansi
local function build_cell_colors(color)
    local bg_ansi
    if type(color) == 'number' then
        bg_ansi = string.format('\27[48;5;%dm', color)
    else
        local r, g, b = hex_to_rgb(color)
        local code = rgb_to_ansi256(r, g, b)
        bg_ansi = string.format('\27[48;5;%dm', code)
    end
    return bg_ansi, '\27[38;5;15m'
end

local function format_emoji_field(emoji)
    if not emoji then return '❓' end

    local emoji_padding_overrides = {
        ['🦣'] = '🦣 ',
        ['🪲'] = '🪲 ',
        ['🕷️'] = '🕷️ ',
        ['⭐'] = '⭐',
        ['🪰'] = '🪰 ',
        ['🦭'] = '🦭 ',
        ['🐻'] = '🐻',
        ['🪼'] = '🪼 ',
        ['🦤'] = '🦤 ',
        ['🦈'] = '🦈'
    }

    return emoji_padding_overrides[emoji] or emoji
end