local _set_animal = function ()
    -- input 1
    local hand_index = 1
    -- input 2 (must be between 1 and 6)
    local biome_index = 1

    local turn = Player_turn
    local hand = Hands[turn]
    local len = #hand
    local card = hand[hand_index]

    -- Board row and column mapping based on player turn
    local board_row = (turn == 1) and 3 or 1
    local column = (biome_index <= 3) and biome_index or (biome_index + 2)

    -- Place the card on the board, keeping the biome structure {biome, index, card}
    local old_cell = Board[board_row][column]
    Board[board_row][column] = {old_cell[1], old_cell[2], card}

    -- Remove the card from hand
    if hand_index < len then
        hand[hand_index] = hand[len]
    end
    hand[len] = nil
end

local _remove_animal = function ()
    -- input 1 (must be between 1 and 6)
    local biome_index = 1

    local turn = Player_turn
    local hand = Hands[turn]

    -- Check if there is an animal on the biome
    -- Remove it
    
end


local _move_animal = function ()
    return 3
end

local _move_biome = function ()
    return 4
end

local _update_ui = function ()
    -- Each player should not see the other hand
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local standby = function ()
    local actions = { _set_animal,
                      _remove_animal,
                      _move_animal,
                      _move_biome}
    local input

    if MODE == 'basic' then
        -- local input = _TUI_input({"number", "Set mode"}, false)
        input = 1
    end

    if input and actions[input] then
        actions[input]()
    end
    _update_ui()
end