--- Fields operations module
-- Works with flat board structure
-- Uses globals: Player_turn, Board, boardModule
-- NOTE: This file is concatenated in build - module available to subsequent files

local fieldsOps = {}

--- Check if field has no card
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return boolean
function fieldsOps.is_empty(slot)
    local field = boardModule.get_field(slot)
    return not field or field.card == nil
end

--- Place card on field
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @param card table
function fieldsOps.set_card(slot, card)
    boardModule.set_field_card(slot, card)
end

--- Remove card from field
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return table|nil Removed card
function fieldsOps.remove_card(slot)
    local field = boardModule.get_field(slot)
    if not field or not field.card then return nil end

    local removed = field.card
    field.card = nil
    return removed
end

--- Swap two fields
-- Uses globals: Player_turn, Board, boardModule
-- @param from number (1-6)
-- @param to number (1-6)
function fieldsOps.move(from, to)
    if from == to then return end
    boardModule.swap_fields(from, to)
end

--- Get card on field
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return table|nil
function fieldsOps.get_card(slot)
    local field = boardModule.get_field(slot)
    return field and field.card
end

--- Get field definition
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return table|nil
function fieldsOps.get_def(slot)
    local field = boardModule.get_field(slot)
    return field and field.def
end

-- Module is local, available to files after this in build order
-- No export needed - files are concatenated in build_battle.txt
