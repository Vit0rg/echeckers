local _draw_card = function(turn)
    if #Decks[turn] == 0 then
        UI.display('No cards on deck, skipping')
        return
    end

    local idx = 1
    local deck_size = #Decks[turn]

    Hands[turn][(#Hands[turn])+1] = process_card(Decks[turn][idx])

    -- O(1) removal: swap with last element instead of shifting
    if deck_size > 0 then
        Decks[turn][idx] = Decks[turn][deck_size]
        Decks[turn][deck_size] = nil
    end
end