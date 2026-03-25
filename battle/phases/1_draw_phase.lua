local _update_ui = function ()
    -- Each player should not see the other hand
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local _discard = function ()
    return
end

local _check_hand_size = function ()
    if #Hands[Player_turn] > HAND_LIMIT then
        UI.display("Discard one")
        _discard()
    end
end

local draw = function ()
    if MODE == 'basic' then
        _draw_card(Player_turn)
        _update_ui()
        return
    end
end