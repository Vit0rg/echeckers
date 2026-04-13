local _discard = function ()
    if #Hands[Player_turn] > HAND_LIMIT then
        UI.display("Discard one card (not yet implemented)")
    end
end

local draw = function ()
    if MODE == 'basic' then
        _draw_card(Decks[Player_turn], Hands[Player_turn])
        return
    end
end