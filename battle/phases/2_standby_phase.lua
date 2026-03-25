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

    if hand_index < len then
        hand[hand_index] = hand[len]
    end
    hand[len] = nil

    return true
end

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

local _move_animal = function(from_biome_index, to_biome_index)
    return 3
end

local _move_biome = function(from_biome_index, to_biome_index)
    from_biome_index = from_biome_index or 1
    to_biome_index = to_biome_index or 2

    local turn = Player_turn

    local valid, err = StandbyValidation.validate_biome_move(turn, from_biome_index, to_biome_index)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    return BiomesOps.move(turn, from_biome_index, to_biome_index)
end

local _update_ui = function()
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local standby = function()
    local actions = { _set_animal, _remove_animal, _move_animal, _move_biome }
    local input

    if MODE == 'basic' then
        input = 1
    end

    if input and actions[input] then
        actions[input]()
    end
    _update_ui()
end
