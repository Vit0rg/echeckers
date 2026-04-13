--- Board module - flat table structure
-- Uses globals: Player_turn, Board
-- NOTE: This file is concatenated in build - module available to subsequent files
-- Index mapping:
--   1-6:  Player 2 fields
--   7-12: Player 1 fields

local boardModule = {}

--- Get field index for player
-- @param player number (1 or 2)
-- @param index number (1-6)
-- @return number Flat table index
function boardModule.field_index(player, index)
    if player == 1 then
        return 7 + index - 1
    else
        return 1 + index - 1
    end
end

--- Get player from field index
-- @param index number (1-12)
-- @return number Player (1 or 2)
function boardModule.field_player(index)
    if index <= 6 then return 2 end
    return 1
end

--- Get field slot (1-6) from flat index
-- @param index number (1-12)
-- @return number Field slot
function boardModule.field_slot(index)
    if index <= 6 then return index end
    return index - 6
end

--- Initialize board with flat structure
-- @param fields_p1 table Player 1's fields (array of 6)
-- @param fields_p2 table Player 2's fields (array of 6)
-- @return table Board instance
function boardModule.init(fields_p1, fields_p2)
    local board = {}

    -- Fields: {def, card}
    -- P2 fields (1-6), P1 fields (7-12)
    for i = 1, 6 do
        board[i] = { def = fields_p2[i], card = nil }
        board[i + 6] = { def = fields_p1[i], card = nil }
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

--- Get field by player and slot
-- Uses global: Player_turn
-- @param slot number (1-6)
-- @return table|nil Field {def, card}
function boardModule.get_field(slot)
    if not Board then return nil end
    local idx = boardModule.field_index(Player_turn, slot)
    return Board[idx]
end

--- Set field card
-- Uses global: Player_turn
-- @param slot number (1-6)
-- @param card table|nil
function boardModule.set_field_card(slot, card)
    local field = boardModule.get_field(slot)
    if field then
        field.card = card
    end
end

--- Alias: set_card for backward compatibility
function boardModule.set_card(slot, card)
    boardModule.set_field_card(slot, card)
end

--- Check if field has no card
-- @param slot number (1-6)
-- @return boolean
function boardModule.is_empty(slot)
    local field = boardModule.get_field(slot)
    return not field or field.card == nil
end

--- Remove card from field
-- @param slot number (1-6)
-- @return table|nil Removed card
function boardModule.remove_card(slot)
    local field = boardModule.get_field(slot)
    if not field or not field.card then return nil end
    local removed = field.card
    field.card = nil
    return removed
end

--- Alias: move (swap) for backward compatibility
function boardModule.move(from, to)
    boardModule.swap_fields(from, to)
end

--- Get card on field
-- @param slot number (1-6)
-- @return table|nil
function boardModule.get_card(slot)
    local field = boardModule.get_field(slot)
    return field and field.card
end

--- Get field definition
-- @param slot number (1-6)
-- @return table|nil
function boardModule.get_def(slot)
    local field = boardModule.get_field(slot)
    return field and field.def
end

--- Get visual layout row for UI
-- @param player number (1 or 2)
-- @return table Layout row (10 cells)
function boardModule.get_layout_row(player)
    if not Board then return {} end

    if player == 2 then
        -- P2 row: fields 1-3, Deck, Trash, fields 4-6, LIFE, BIOMATTER
        return {
            Board[1], Board[2], Board[3],
            Board.deck_p2, Board.trash_p2,
            Board[4], Board[5], Board[6],
            Board.life_p2, Board.biomatter_p2
        }
    else
        -- P1 row: fields 1-3, LIFE, BIOMATTER, fields 4-6, Deck, Trash
        return {
            Board[7], Board[8], Board[9],
            Board.life_p1, Board.biomatter_p1,
            Board[10], Board[11], Board[12],
            Board.deck_p1, Board.trash_p1
        }
    end
end

--- Get middle layout row
-- @return table Middle row (5 cells)
function boardModule.get_middle_row()
    return { '', 'SETUP', '', '', '' }
end

--- Swap two fields
-- Uses global: Player_turn
-- @param slot1 number (1-6)
-- @param slot2 number (1-6)
function boardModule.swap_fields(slot1, slot2)
    local idx1 = boardModule.field_index(Player_turn, slot1)
    local idx2 = boardModule.field_index(Player_turn, slot2)
    Board[idx1], Board[idx2] = Board[idx2], Board[idx1]
end

-- Module is local, available to files after this in build order
-- No export needed - files are concatenated in build_battle.txt
