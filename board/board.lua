--- Board module - manages board structure and layout
-- Separates biome data from visual layout

BoardModule = {}

--- Initialize board structure for basic mode
---@param biomes_p1 table Player 1's biomes (array of 6)
---@param biomes_p2 table Player 2's biomes (array of 6)
---@return table Board instance
function BoardModule.init(biomes_p1, biomes_p2)
    local board = {
        -- Biome data per player (game logic source of truth)
        biomes = {
            [1] = {},  -- Player 1
            [2] = {},  -- Player 2
        },

        -- Visual layout for UI rendering
        layout = {
            [1] = {},  -- Player 2 row (top)
            [2] = {},  -- Middle zone
            [3] = {},  -- Player 1 row (bottom)
        },
    }

    -- Initialize biomes with animal slots
    for i = 1, 6 do
        board.biomes[1][i] = { def = biomes_p1[i], animal = nil }
        board.biomes[2][i] = { def = biomes_p2[i], animal = nil }
    end

    -- Build visual layout from biomes
    -- Layout: [biome1-3, Deck, Trash, biome4-6, LIFE, BIOMATTER]
    board.layout[1] = {
        board.biomes[2][1], board.biomes[2][2], board.biomes[2][3],
        'Deck', 'Trash',
        board.biomes[2][4], board.biomes[2][5], board.biomes[2][6],
        'LIFE', 'BIOMATTER'
    }

    board.layout[2] = { '', 'SETUP', '', '', '' }

    board.layout[3] = {
        board.biomes[1][1], board.biomes[1][2], board.biomes[1][3],
        'LIFE', 'BIOMATTER',
        board.biomes[1][4], board.biomes[1][5], board.biomes[1][6],
        'Deck', 'Trash'
    }

    return board
end

--- Get biome by player and index
---@param player number (1 or 2)
---@param index number (1-6)
---@return table|nil Biome {def, animal}
function BoardModule.get_biome(player, index)
    if Board.biomes and Board.biomes[player] then
        return Board.biomes[player][index]
    end
    return nil
end

--- Get player's visual row (1 for P2, 3 for P1)
---@param player number
---@return number
function BoardModule.get_row(player)
    return (player == 1) and 3 or 1
end

--- Get column index for biome in layout
---@param index number (1-6)
---@return number Column (1-3 or 6-8)
function BoardModule.get_column(index)
    if index <= 3 then
        return index
    else
        return index + 2  -- Skip Deck/Trash at 4,5
    end
end

--- Sync layout with biome changes
function BoardModule.sync()
    if not Board.biomes then return end
    for i = 1, 6 do
        local col = BoardModule.get_column(i)
        Board.layout[1][col] = Board.biomes[2][i]
        Board.layout[3][col] = Board.biomes[1][i]
    end
end
