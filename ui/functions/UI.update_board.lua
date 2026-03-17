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
        bg_ansi = '\27[48;5;' .. color .. 'm'
    else
        local r, g, b = hex_to_rgb(color)
        local code = rgb_to_ansi256(r, g, b)
        bg_ansi = '\27[48;5;' .. code .. 'm'
    end
    return bg_ansi, '\27[38;5;15m'
end

--- Render board with styling
local function render_board(board)
    local ANSI_RESET = '\27[0m'
    local GREY_ROW3 = 235
    local DECK_COLOR = 238
    local GREY_DARK = 234
    local BIOMATTER_COLOR = 226
    local HEALTH_COLOR = 22
    local TRASH_COLOR = 94
    local CELL_SIZES = {12, 12, 12, 14, 14}

    -- Cell color configuration: CELL_COLORS[row][col] = color_code
    local CELL_COLORS = {
        [1] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
        [2] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [3] = {GREY_ROW3, GREY_ROW3, GREY_ROW3, GREY_DARK, GREY_DARK},
        [4] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [5] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
    }

    local function get_cell_color(row, col)
        return CELL_COLORS[row] and CELL_COLORS[row][col]
    end

    local function get_biome_data(row, col)
        if col > 3 then
            return nil
        end
        local biome_map = {
            [1] = Biomes[2],
            [2] = Biomes[2],
            [4] = Biomes[1],
            [5] = Biomes[1],
        }
        local biome = biome_map[row]
        if biome and biome[col] then
            return biome[col]
        end
        return nil
    end

    local function render_cell(row, col, cell_content, biome_data)
        local cell_size = CELL_SIZES[col]
        local bg_ansi, fg_ansi, text

        if biome_data and biome_data.color then
            bg_ansi, fg_ansi = build_cell_colors(biome_data.color)
            text = string.center(biome_data.name or cell_content, cell_size)
        else
            local color = get_cell_color(row, col)
            if color then
                bg_ansi, fg_ansi = build_cell_colors(color)
            end
            text = string.center(cell_content, cell_size)
        end

        if bg_ansi and fg_ansi then
            return bg_ansi .. fg_ansi .. text .. ANSI_RESET
        end
        return text
    end

    local function render_separator(bg_ansi, fg_ansi)
        return bg_ansi .. fg_ansi .. ' ' .. ANSI_RESET
    end

    local lines = {}
    local lines_n = 0

    local board_width = 2
    for i = 1, #CELL_SIZES do
        board_width = board_width + CELL_SIZES[i]
    end

    local sep_bg, sep_fg = build_cell_colors(GREY_ROW3)

    lines_n = lines_n + 1
    lines[lines_n] = sep_bg .. sep_fg .. string.rep(' ', board_width) .. ANSI_RESET

    for row = 1, #board do
        local line = ''
        local row_cells = board[row]

        line = line .. render_separator(sep_bg, sep_fg)

        for col = 1, 5 do
            local cell = row_cells[col]
            local biome_data = get_biome_data(row, col)
            line = line .. render_cell(row, col, cell, biome_data)
        end

        line = line .. render_separator(sep_bg, sep_fg)

        lines_n = lines_n + 1
        lines[lines_n] = line
    end

    lines_n = lines_n + 1
    lines[lines_n] = lines[1]

    print('\n' .. table.concat(lines, '\n') .. '\n')
end

---@diagnostic disable-next-line: duplicate-set-field
UI.update_board = function (board)
    if BUILD == 'TUI' then
        render_board(board)
    end
end
