--- Board module - flat table structure
-- Index mapping:
--   1-6:  Player 2 biomes
--   7-12: Player 1 biomes
--   13-14: Player 2 Deck/Trash
--   15-16: Player 1 Deck/Trash
--   17-18: Player 2 LIFE/BIOMATTER
--   19-20: Player 1 LIFE/BIOMATTER

BoardModule = {}

-- Constants for index mapping
BoardModule.P2_BIOME_START = 1
BoardModule.P1_BIOME_START = 7
BoardModule.BIOMES_PER_PLAYER = 6

--- Get biome index for player
---@param player number (1 or 2)
---@param index number (1-6)
---@return number Flat table index
function BoardModule.biome_index(player, index)
    if player == 1 then
        return BoardModule.P1_BIOME_START + index - 1
    else
        return BoardModule.P2_BIOME_START + index - 1
    end
end

--- Get player from biome index
---@param index number (1-12)
---@return number Player (1 or 2)
function BoardModule.biome_player(index)
    if index <= 6 then return 2 end
    return 1
end

--- Get biome slot (1-6) from flat index
---@param index number (1-12)
---@return number Biome slot
function BoardModule.biome_slot(index)
    if index <= 6 then return index end
    return index - 6
end

--- Initialize board with flat structure
---@param biomes_p1 table Player 1's biomes (array of 6)
---@param biomes_p2 table Player 2's biomes (array of 6)
---@return table Board instance
function BoardModule.init(biomes_p1, biomes_p2)
    local board = {}

    -- Biomes: {def, animal}
    for i = 1, 6 do
        board[i] = { def = biomes_p2[i], animal = nil }      -- P2 biomes
        board[i + 6] = { def = biomes_p1[i], animal = nil }  -- P1 biomes
    end

    -- Special zones
    board.deck_p2 = 'Deck'
    board.trash_p2 = 'Trash'
    board.deck_p1 = 'Deck'
    board.trash_p1 = 'Trash'
    board.life_p2 = 2000
    board.biomatter_p2 = 3
    board.life_p1 = 2000
    board.biomatter_p1 = 3

    return board
end

--- Get biome by player and slot
---@param player number (1 or 2)
---@param slot number (1-6)
---@return table|nil Biome {def, animal}
function BoardModule.get_biome(player, slot)
    if not Board then return nil end
    local idx = BoardModule.biome_index(player, slot)
    return Board[idx]
end

--- Set biome animal
---@param player number (1 or 2)
---@param slot number (1-6)
---@param card table|nil
function BoardModule.set_biome_animal(player, slot, card)
    local biome = BoardModule.get_biome(player, slot)
    if biome then
        biome.animal = card
    end
end

--- Get visual layout row for UI
---@param player number (1 or 2)
---@return table Layout row (10 cells)
function BoardModule.get_layout_row(player)
    if not Board then return {} end

    if player == 2 then
        -- P2 row: biomes 1-3, Deck, Trash, biomes 4-6, LIFE, BIOMATTER
        return {
            Board[1], Board[2], Board[3],
            Board.deck_p2, Board.trash_p2,
            Board[4], Board[5], Board[6],
            Board.life_p2, Board.biomatter_p2
        }
    else
        -- P1 row: biomes 1-3, LIFE, BIOMATTER, biomes 4-6, Deck, Trash
        return {
            Board[7], Board[8], Board[9],
            Board.life_p1, Board.biomatter_p1,
            Board[10], Board[11], Board[12],
            Board.deck_p1, Board.trash_p1
        }
    end
end

--- Get middle layout row
---@return table Middle row (5 cells)
function BoardModule.get_middle_row()
    return { '', 'SETUP', '', '', '' }
end

--- Swap two biomes for a player
---@param player number (1 or 2)
---@param slot1 number (1-6)
---@param slot2 number (1-6)
function BoardModule.swap_biomes(player, slot1, slot2)
    local idx1 = BoardModule.biome_index(player, slot1)
    local idx2 = BoardModule.biome_index(player, slot2)
    Board[idx1], Board[idx2] = Board[idx2], Board[idx1]
end
