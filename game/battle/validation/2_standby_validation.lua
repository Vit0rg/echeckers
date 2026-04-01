--- Validation for standby phase operations
-- Uses global state directly (Player_turn, Hands, Board)
-- Functions do not receive arguments except indices

local standbyValidation = {}

--- Validate biome index is in range 1-6
-- @param index number Biome slot to validate
-- @return boolean True if valid
function standbyValidation.valid_biome_index(index)
    return type(index) == 'number' and index >= 1 and index <= 6
end

--- Validate set animal operation
-- Uses globals: Player_turn, Hands, Board
-- @param hand_index number Index in current player's hand
-- @param biome_index number Biome slot (1-6)
-- @return boolean valid
-- @return string|nil error message
function standbyValidation.validate_set_animal(hand_index, biome_index)
    -- Validate biome index
    if not standbyValidation.valid_biome_index(biome_index) then
        return false, 'Invalid biome index (1-6)'
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
    
    -- Validate biome is empty
    if not fieldsOps.is_empty(biome_index) then
        return false, 'Biome already occupied'
    end

    return true
end

--- Validate remove animal operation
-- Uses globals: Player_turn, Board, fieldsOps
-- @param biome_index number Biome slot (1-6)
-- @return boolean valid
-- @return string|nil error message
function standbyValidation.validate_remove_animal(biome_index)
    -- Validate biome index
    if not standbyValidation.valid_biome_index(biome_index) then
        return false, 'Invalid biome index (1-6)'
    end

    -- Validate board initialized
    if not Board then
        return false, 'Board not initialized'
    end

    -- Validate biome has animal
    if fieldsOps.is_empty(biome_index) then
        return false, 'No animal on biome'
    end
    
    return true
end

--- Validate biome move (swap positions) operation
-- Uses globals: Player_turn, Board
-- @param from_biome number Source biome slot (1-6)
-- @param to_biome number Destination biome slot (1-6)
-- @return boolean valid
-- @return string|nil error message
function standbyValidation.validate_biome_move(from_biome, to_biome)
    -- Validate biome indices
    if not standbyValidation.valid_biome_index(from_biome) then
        return false, 'Invalid source biome (1-6)'
    end
    if not standbyValidation.valid_biome_index(to_biome) then
        return false, 'Invalid destination biome (1-6)'
    end
    
    -- Validate different biomes
    if from_biome == to_biome then
        return false, 'Source and destination must differ'
    end
    
    -- Validate board initialized
    if not Board then
        return false, 'Board not initialized'
    end
    
    return true
end

-- Export to global scope for use in standby phase
StandbyValidation = standbyValidation
