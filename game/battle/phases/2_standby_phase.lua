--- Place an animal card from hand onto a biome
-- Uses globals: Player_turn, Hands, Board
-- @param hand_index number Index in hand (1-4)
-- @param biome_index number Biome slot (1-6)
-- @return boolean Success
local _set_animal = function(hand_index, biome_index)
    hand_index = hand_index or 1
    biome_index = biome_index or 1

    local hand = Hands[Player_turn]
    local len = #hand
    local card = hand[hand_index]

    local valid, err = StandbyValidation.validate_set_animal(hand_index, biome_index)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    fieldsOps.set_animal(biome_index, card)

    -- Remove card from hand by swapping with last element
    if hand_index < len then
        hand[hand_index] = hand[len]
    end
    hand[len] = nil

    return true
end

--- Remove an animal from a biome and return it to hand
-- Uses globals: Player_turn, Hands, Board
-- @param biome_index number Biome slot (1-6)
-- @return boolean Success
local _remove_animal = function(biome_index)
    biome_index = biome_index or 1

    local hand = Hands[Player_turn]

    local valid, err = StandbyValidation.validate_remove_animal(biome_index)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    local removed = fieldsOps.remove_animal(biome_index)
    if removed then
        hand[#hand + 1] = removed
    end

    return true
end

--- Move an animal from one biome to another (swap positions)
-- Uses globals: Player_turn, Board, fieldsOps, UI, StandbyValidation
-- @param from_biome number Source biome slot (1-6)
-- @param to_biome number Destination biome slot (1-6)
-- @return boolean Success
local _move_animal = function(from_biome, to_biome)
    from_biome = from_biome or 1
    to_biome = to_biome or 2

    -- Validate source biome has an animal
    if fieldsOps.is_empty(from_biome) then
        UI.display('Invalid move: No animal on source biome')
        return false
    end

    -- Validate destination biome index and different from source
    if not StandbyValidation.valid_biome_index(to_biome) then
        UI.display('Invalid move: Destination biome must be 1-6')
        return false
    end

    if from_biome == to_biome then
        UI.display('Invalid move: Source and destination must differ')
        return false
    end

    fieldsOps.move(from_biome, to_biome)
    return true
end

--- Move/swap two biomes (change their positions)
-- Uses globals: Player_turn, Board
-- @param from_biome number Source biome slot (1-6)
-- @param to_biome number Destination biome slot (1-6)
-- @return boolean Success
local _move_biome = function(from_biome, to_biome)
    from_biome = from_biome or 1
    to_biome = to_biome or 2

    local valid, err = StandbyValidation.validate_biome_move(from_biome, to_biome)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    return fieldsOps.move(from_biome, to_biome)
end

--- Update UI display
local _update_ui = function()
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

--- Standby phase - player action phase
-- Uses globals: Player_turn, Hands, Board, UI, BUILD
-- Players can set animals, remove animals, move animals, or move biomes
-- NOTE: This file is concatenated in build - do NOT return at file end
local standby = function()
    -- Define action options and handlers
    local options = {'Set Animal', 'Move Animal', 'Remove Animal', 'Move Biome'}
    local actions = { _set_animal, _move_animal, _remove_animal, _move_biome }
    local action_count = #actions
    
    -- Build menu output using C-based loop
    local output = string.format("\nStandby Phase - Player %d\n\nSelect Action:\n", Player_turn)
    for i = 1, action_count do
        output = output .. string.format("  [%d] %s\n", i, options[i])
    end

    UI.update_menu(output)
    _update_ui()

    -- Get player input (1-4)
    local input
    if BUILD == 'TUI' then
        -- TODO: Integrate with UI.input() for actual input
        -- For now, default to first option as placeholder
        input = 1
    else
        input = 1
    end

    -- Validate input and execute selected action
    if input >= 1 and input <= action_count then
        -- Execute action with default parameters
        -- TODO: Pass actual parameters from user input
        local success = actions[input]()
        _update_ui()
        return success
    end
    
    UI.display('Invalid selection')
    return false
end
-- DO NOT add 'return standby' - this file is concatenated in build process
