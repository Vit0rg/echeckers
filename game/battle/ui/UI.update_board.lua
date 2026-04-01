--- Center text ignoring ANSI escape codes
---@param text string
---@param width number
---@return string
local function center_ansi(text, width)
    text = tostring(text)
    local clean = text:gsub('\27%[[%d;]*m', '')
    local padding = width - #clean
    if padding <= 0 then return text end
    local left = math.floor(padding / 2)
    return string.rep(' ', left) .. text .. string.rep(' ', padding - left)
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

    local CELL_COLORS = {
        [1] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
        [2] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [3] = {GREY_ROW3, GREY_ROW3, GREY_ROW3, GREY_ROW3, GREY_ROW3},
        [4] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [5] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
    }

    local grey_bg = '\27[48;5;235m'
    local sep_bg, sep_fg = build_cell_colors(GREY_ROW3)
    local separator = sep_bg .. sep_fg .. ' ' .. ANSI_RESET

    local function build_colored_text(text, color)
        local bg, fg = build_cell_colors(color)
        return bg .. fg .. text .. ANSI_RESET
    end

    local VISUAL_MAP = {
        [1] = {row_func = 'get_layout_row', player = 2, cols = {1, 2, 3, 4, 5}},
        [2] = {row_func = 'get_layout_row', player = 2, cols = {6, 7, 8, 9, 10}},
        [3] = {row_func = 'get_middle_row', cols = {1, 2, 3, 4, 5}},
        [4] = {row_func = 'get_layout_row', player = 1, cols = {1, 2, 3, 4, 5}},
        [5] = {row_func = 'get_layout_row', player = 1, cols = {6, 7, 8, 9, 10}},
    }

    local board_width = 2
    for i = 1, 5 do
        board_width = board_width + CELL_SIZES[i]
    end

    local border_line = sep_bg .. sep_fg .. string.rep(' ', board_width) .. ANSI_RESET
    local lines = {border_line}

    -- Cell content extraction: returns {text, color, is_card}
    local cell_extractors = {
        -- Animal on biome: {def, animal}
        function(cell)
            if cell.animal and cell.animal.name then
                return format_emoji_field(cell.animal.emoji or cell.animal.name),
                       cell.def.color, true
            end
        end,
        -- Biome definition
        function(cell)
            if cell.def and cell.def.name then
                return center_ansi(cell.def.name, CELL_SIZES[1]), cell.def.color, false
            end
        end,
        -- Empty/occupied state
        function(cell)
            if cell.def then
                return center_ansi(cell.animal and 'occupied' or 'empty', CELL_SIZES[1]), nil, false
            end
        end,
        -- Plain table with name
        function(cell)
            if cell.name then
                return center_ansi(cell.name, CELL_SIZES[1]), nil, false
            end
        end,
    }

    local function get_cell_content(cell, row, col)
        -- String cells: use CELL_COLORS
        if type(cell) ~= 'table' then
            return center_ansi(cell or '', CELL_SIZES[col]), CELL_COLORS[row][col], false
        end

        -- Table cells: use extractors
        local size = #cell_extractors
        for i = 1, size do
            local text, color, is_card = cell_extractors[i](cell)
            if text then return text, color, is_card end
        end

        return center_ansi(tostring(cell), CELL_SIZES[col]), nil, false
    end

    local function render_cell(row, col, cell)
        local text, color, is_card = get_cell_content(cell, row, col)
        local cell_size = CELL_SIZES[col]

        if is_card then
            local padding = cell_size - 2
            local left = math.floor(padding / 2)
            if color then
                local bg, fg = build_cell_colors(color)
                return bg .. fg .. string.rep(' ', left) .. grey_bg .. text .. ANSI_RESET ..
                       bg .. fg .. string.rep(' ', padding - left) .. ANSI_RESET
            end
            return grey_bg .. text .. ANSI_RESET
        end

        if color then
            return build_colored_text(text, color)
        end

        return text .. ANSI_RESET
    end

    for visual_row = 1, 5 do
        local row_parts = {separator}
        local mapping = VISUAL_MAP[visual_row]
        local layout_row

        if mapping.row_func == 'get_layout_row' then
            layout_row = BoardModule.get_layout_row(mapping.player)
        else
            layout_row = BoardModule.get_middle_row()
        end

        for col = 1, 5 do
            local cell = layout_row and layout_row[mapping.cols[col]]
            row_parts[col + 1] = render_cell(visual_row, col, cell)
        end

        row_parts[7] = separator
        lines[visual_row + 1] = table.concat(row_parts)
    end

    lines[7] = border_line
    print('\n' .. table.concat(lines, '\n') .. '\n')
end

---@diagnostic disable-next-line: duplicate-set-field
UI.update_board = function(board)
    if BUILD == 'TUI' then
        _TUI_update_board(board)
    end
end
