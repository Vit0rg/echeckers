local _draw_card = function()
    local i = Player_turn
    local card_to_draw = nil
    local idx = 1
    local deck_size = #Decks[i]

    if deck_size > 0 then
        card_to_draw = Decks[i][idx]
        -- O(1) removal: swap with last element instead of shifting
        Decks[i][idx] = Decks[i][deck_size]
        Decks[i][deck_size] = nil
    end

    if card_to_draw then
        if card_to_draw.emoji == nil then
            UI.display("Error: Card has no emoji!")
            return
        end
        Hands[i][(#Hands[i])+1] = card_to_draw
    else
        UI.display("No cards left to draw!")
        return
    end
end