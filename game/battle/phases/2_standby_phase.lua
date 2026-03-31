--- Place an animal card from hand onto a biome
-- @param hand_index number Index in hand (1-4)
-- @param biome_index number Biome slot (1-6)
-- @return boolean Success
local _set_animal = function(hand_index, biome_index)
    hand_index = hand_index or 1
    biome_index = biome_index or 1

    local turn = Player_turn
    local hand = Hands[turn]
    local len = #hand
    local card = hand[hand_index]

    local valid, err = StandbyValidation.validate_set_animal(turn, biome_index, hand, hand_index)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    BiomesOps.set_animal(turn, biome_index, card)

    -- Remove card from hand by swapping with last element
    if hand_index < len then
        hand[hand_index] = hand[len]
    end
    hand[len] = nil

    return true
end

--- Remove an animal from a biome and return it to hand
-- @param biome_index number Biome slot (1-6)
-- @return boolean Success
local _remove_animal = function(biome_index)
    biome_index = biome_index or 1

    local turn = Player_turn
    local hand = Hands[turn]

    local valid, err = StandbyValidation.validate_remove_animal(turn, biome_index)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    local removed = BiomesOps.remove_animal(turn, biome_index)
    if removed then
        hand[#hand + 1] = removed
    end

    return true
end

--- Move an animal from one biome to another (swap positions)
-- @param from_biome number Source biome slot (1-6)
-- @param to_biome number Destination biome slot (1-6)
-- @return boolean Success
local _move_animal = function(from_biome, to_biome)
    from_biome = from_biome or 1
    to_biome = to_biome or 2

    local turn = Player_turn

    -- Validate source biome has an animal
    if BiomesOps.is_empty(turn, from_biome) then
        UI.display('Invalid move: No animal on source biome')
        return false
    end

    -- Validate destination is different
    if from_biome == to_biome then
        UI.display('Invalid move: Source and destination must differ')
        return false
    end

    -- Validate destination biome index
    if not StandbyValidation.valid_biome_index(to_biome) then
        UI.display('Invalid move: Destination biome must be 1-6')
        return false
    end

    BiomesOps.move(turn, from_biome, to_biome)
    return true
end

--- Move/swap two biomes (change their positions)
-- @param from_biome number Source biome slot (1-6)
-- @param to_biome number Destination biome slot (1-6)
-- @return boolean Success
local _move_biome = function(from_biome, to_biome)
    from_biome = from_biome or 1
    to_biome = to_biome or 2

    local turn = Player_turn

    local valid, err = StandbyValidation.validate_biome_move(turn, from_biome, to_biome)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    return BiomesOps.move(turn, from_biome, to_biome)
end

--- Update UI display
local _update_ui = function()
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

--- Standby phase - player action phase
-- Players can set animals, remove animals, move animals, or move biomes
local standby = function()
    local options = {'Set Animal', 'Move Animal', 'Remove Animal', 'Move Biome'}
    local actions = { _set_animal, _move_animal, _remove_animal, _move_biome }
    local output = string.format("\nStandby Phase - Player %d\n\nSelect Action:\n  [1] %s\n  [2] %s\n  [3] %s\n  [4] %s\n",
                            Player_turn, options[1], options[2], options[3], options[4])

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

    -- Execute selected action with default parameters
    -- TODO: Pass actual parameters from user input
    local success = actions[input]()

    _update_ui()
    return success
end

return standby
