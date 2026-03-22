--- Center text ignoring ANSI escape codes
---@param text string Text with possible ANSI codes
---@param width number Desired width
---@return string Centered text
local function center_ansi(text, width)
    text = tostring(text)
    local clean = text:gsub('\27%[[%d;]*m', '')
    local padding = width - #clean
    if padding <= 0 then return text end
    local left = math.floor(padding / 2)
    local right = padding - left
    return string.rep(' ', left) .. text .. string.rep(' ', right)
end

--- Render board with styling
local function _TUI_update_board(board)
    local ANSI_RESET = '\27[0m'
    local GREY_ROW3 = 235
    local DECK_COLOR = 238
    local BIOMATTER_COLOR = 226
    local HEALTH_COLOR = 22
    local TRASH_COLOR = 94
    local CELL_SIZES = {14, 14, 14, 16, 16}

    -- Cell color configuration: CELL_COLORS[row][col] = color_code
    local CELL_COLORS = {
        [1] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
        [2] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [3] = {GREY_ROW3, GREY_ROW3, GREY_ROW3, GREY_ROW3, GREY_ROW3},
        [4] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [5] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
    }

    local grey_bg = '\27[48;5;235m'

    --- Build ANSI colored text
    ---@param text string
    ---@param color number
    ---@return string
    local function build_colored_text(text, color)
        local bg, fg = build_cell_colors(color)
        return bg .. fg .. text .. ANSI_RESET
    end

    --- Get cell color for special cells (Deck, Trash, LIFE, BIOMATTER)
    local function get_cell_color(row, col)
        return CELL_COLORS[row] and CELL_COLORS[row][col]
    end

    --- Extract biome from cell {biome, index, card}
    local function get_biome(cell)
        if type(cell) ~= 'table' then return nil end
        -- Cell structure: {biome_data, index, card}
        for i = 1, #cell do
            local v = cell[i]
            if type(v) == 'table' and v.name then
                return v
            end
        end
        return nil
    end

    --- Check if cell contains a card
    local function get_card(cell)
        if type(cell) ~= 'table' then return nil end
        -- Cell structure: {biome_data, index, card}
        for i = 1, #cell do
            local v = cell[i]
            if type(v) == 'table' and v.emoji then
                return v
            end
        end
        return nil
    end

    --- Render a single cell
    local function render_cell(row, col, cell)
        local cell_size = CELL_SIZES[col]
        local biome = get_biome(cell)
        local card = get_card(cell)
        local color

        -- Priority: biome color > special cell color (Deck, Trash, etc.)
        if biome and biome.color then
            color = biome.color
        else
            color = get_cell_color(row, col)
        end

        -- Card rendering: emoji centered with grey background
        if card and card.name then
            local emoji = format_emoji_field(card.emoji or card.name)
            local padding = cell_size - 2
            local left = math.floor(padding / 2)
            local right = padding - left

            if color then
                local bg, fg = build_cell_colors(color)
                return bg .. fg .. string.rep(' ', left) ..
                       grey_bg .. emoji .. ANSI_RESET ..
                       bg .. fg .. string.rep(' ', right) .. ANSI_RESET
            end
            return grey_bg .. emoji .. ANSI_RESET
        end

        -- Biome rendering
        local display_text
        if biome and biome.name then
            display_text = center_ansi(biome.name, cell_size)
        elseif type(cell) == 'table' then
            -- Non-biome table cell (LIFE, BIOMATTER, etc.)
            local value
            for i = 1, #cell do
                local v = cell[i]
                if type(v) ~= 'table' or not v.name then
                    value = v
                    break
                end
            end
            display_text = center_ansi(value or tostring(cell), cell_size)
        else
            display_text = center_ansi(cell or '', cell_size)
        end

        local result
        if color then
            result = build_colored_text(display_text, color)
        else
            result = display_text .. ANSI_RESET
        end
        return result
    end

    -- Board structure mapping:
    -- board[1] = {biomes2[1-3], Deck, Trash, biomes2[4-6], LIFE, BIOMATTER} (10 cells)
    -- board[2] = {'', 'SETUP', '', '', ''} (5 cells)
    -- board[3] = {biomes1[1-3], LIFE, BIOMATTER, biomes1[4-6], Deck, Trash} (10 cells)
    --
    -- Visual output (5 rows x 5 cols):
    -- Row 1: board[1][1-5]   -> biomes2[1-3], Deck, Trash
    -- Row 2: board[1][6-10]  -> biomes2[4-6], LIFE, BIOMATTER
    -- Row 3: board[2][1-5]   -> SETUP row
    -- Row 4: board[3][1-5]   -> biomes1[1-3], LIFE, BIOMATTER
    -- Row 5: board[3][6-10]  -> biomes1[4-6], Deck, Trash

    local VISUAL_MAP = {
        [1] = {board_row = 1, cols = {1, 2, 3, 4, 5}},
        [2] = {board_row = 1, cols = {6, 7, 8, 9, 10}},
        [3] = {board_row = 2, cols = {1, 2, 3, 4, 5}},
        [4] = {board_row = 3, cols = {1, 2, 3, 4, 5}},
        [5] = {board_row = 3, cols = {6, 7, 8, 9, 10}},
    }

    local lines = {}
    local COL_COUNT = 5
    local VISUAL_ROWS = 5

    -- Pre-calculate board width
    local board_width = 2
    for i = 1, COL_COUNT do
        board_width = board_width + CELL_SIZES[i]
    end

    local sep_bg, sep_fg = build_cell_colors(GREY_ROW3)
    local separator = sep_bg .. sep_fg .. ' ' .. ANSI_RESET

    local border_line = sep_bg .. sep_fg .. string.rep(' ', board_width) .. ANSI_RESET
    lines[1] = border_line

    for visual_row = 1, VISUAL_ROWS do
        local row_parts = {separator}
        local mapping = VISUAL_MAP[visual_row]
        local board_row = board[mapping.board_row]

        for col = 1, COL_COUNT do
            local board_col = mapping.cols[col]
            local cell = board_row and board_row[board_col]
            row_parts[col + 1] = render_cell(visual_row, col, cell)
        end

        row_parts[COL_COUNT + 2] = separator
        lines[visual_row + 1] = table.concat(row_parts)
    end

    lines[VISUAL_ROWS + 2] = border_line

    print('\n' .. table.concat(lines, '\n') .. '\n')
end

---@diagnostic disable-next-line: duplicate-set-field
UI.update_board = function (board)
    if BUILD == 'TUI' then
        _TUI_update_board(board)
    end
end
