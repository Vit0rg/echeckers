--- Validation for standby phase operations
-- Uses global state directly (Player_turn, Hands, Board)
-- Functions do not receive arguments except indices

local standbyValidation = {}

--- Validate field index is in range 1-6
-- @param index number Field slot to validate
-- @return boolean True if valid
function standbyValidation.valid_field_index(index)
    return type(index) == 'number' and index >= 1 and index <= 6
end

--- Validate set animal operation
-- Uses globals: Player_turn, Hands, Board
-- @param hand_index number Index in current player's hand
-- @param field_index number Field slot (1-6)
-- @return boolean valid
-- @return string|nil error message
function standbyValidation.validate_set_card(hand_index, field_index)
    -- Validate field index
    if not standbyValidation.valid_field_index(field_index) then
        return false, 'Invalid field index (1-6)'
    end
    
    -- Validate board initialized
    if not Board then
        return false, 'Board not initialized'
    end
    
    -- Validate hand and card
    local hand = Hands[Player_turn]
    if not hand or not hand[hand_index] then
        return false, 'Invalid card in hand'
    end
    
    -- Validate field is empty
    if not fieldsOps.is_empty(field_index) then
        return false, 'Field already occupied'
    end

    return true
end

--- Validate remove animal operation
-- Uses globals: Player_turn, Board, fieldsOps
-- @param field_index number Field slot (1-6)
-- @return boolean valid
-- @return string|nil error message
function standbyValidation.validate_remove_animal(field_index)
    -- Validate field index
    if not standbyValidation.valid_field_index(field_index) then
        return false, 'Invalid field index (1-6)'
    end

    -- Validate board initialized
    if not Board then
        return false, 'Board not initialized'
    end

    -- Validate field has animal
    if fieldsOps.is_empty(field_index) then
        return false, 'No animal on field'
    end
    
    return true
end

--- Validate field move (swap positions) operation
-- Uses globals: Player_turn, Board
-- @param from_field number Source field slot (1-6)
-- @param to_field number Destination field slot (1-6)
-- @return boolean valid
-- @return string|nil error message
function standbyValidation.validate_field_move(from_field, to_field)
    -- Validate field indices
    if not standbyValidation.valid_field_index(from_field) then
        return false, 'Invalid source field (1-6)'
    end
    if not standbyValidation.valid_field_index(to_field) then
        return false, 'Invalid destination field (1-6)'
    end
    
    -- Validate different fields
    if from_field == to_field then
        return false, 'Source and destination must differ'
    end
    
    -- Validate board initialized
    if not Board then
        return false, 'Board not initialized'
    end
    
    return true
end
