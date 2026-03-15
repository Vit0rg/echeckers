local _update_ui = function ()
    -- Each player should not see the other hand
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local _discard = function ()
    
end

local _check_hand_size = function ()
    if #Hands[Player_turn] > HAND_LIMIT then
        UI.display("Discard one")
        _discard()
    end
end

draw = function ()
    if MODE == 'basic' then
        if #Decks[Player_turn] == 0 then
            UI.display('No cards on deck, skipping')
            return
        end
        _draw_card()
        _update_ui()
        return
    end
end