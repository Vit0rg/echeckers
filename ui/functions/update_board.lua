BUILD = 'TUI'

local update_board = function (board)
    if BUILD == 'TUI' then
        -- 5x5 grid, width 61
        -- Layout: ||cell1|cell2|cell3||cell4|cell5||
        -- Separators: 2+1+1+2+1+2 = 9 chars
        -- Cells: 61 - 9 = 52 chars
        -- Cells 1-3: 10 chars each (5 emojis × 2 visual chars) = 30 chars
        -- Cell 4: 4 + content + 4 = variable
        -- Cell 5: 13 chars

        local x_size = #board
        local cell_sizes = {10, 10, 10, 10, 13}
        local border = string.rep('-', 61)
        local is_edge_row = (board[1] and board[x_size]) -- true if rows 1 and 5 exist

        local lines = {}
        local lines_n = 0

        for i = 1, x_size do
            local is_first_or_last = (i == 1 or i == 5)
            local row_cells = board[i]

            -- Build row string directly
            local line = '||'

            for c = 1, 5 do
                local cell = row_cells[c]
                local cell_size = cell_sizes[c]

                -- Inline is_emoji check: first byte >= 192
                local is_emoji_cell = #cell > 0 and string.byte(cell, 1) >= 192
                local should_fill = is_edge_row and is_first_or_last and (c <= 3) and is_emoji_cell

                local content
                if should_fill then
                    content = string.center(string.rep(cell, 5), cell_size)
                else
                    content = string.center(cell, cell_size)
                end

                -- Add prefix/suffix for cells 4 and 5 on edge rows
                if is_first_or_last then
                    if c == 5 then
                        content = content .. ' '
                    end
                end

                -- Remove 1 trailing space from cell 5 on rows 2, 3 and 4
                if (i >= 2 and i <= 4) and c == 5 then
                    content = content:sub(1, -2)
                end

                line = line .. content

                -- Separators: | after 1,2,4 | after 3 ||
                if c == 1 or c == 2 or c == 4 then
                    line = line .. '|'
                elseif c == 3 then
                    line = line .. '||'
                end
            end

            line = line .. '||'

            lines_n = lines_n + 1
            lines[lines_n] = border
            lines_n = lines_n + 1
            lines[lines_n] = line
        end
        lines_n = lines_n + 1
        lines[lines_n] = border

        return table.concat(lines, '\n')
    end
end