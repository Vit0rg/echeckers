-- Draw card(s) from a deck table into a hand table
-- @param deck table The deck to draw from
-- @param hand table The hand to draw into
-- @param count number? Number of cards to draw (default 1)
-- @return nil
local _draw_card = function(deck, hand, count)
    count = count or 1

    for i = 1, count do
        if #deck == 0 then
            UI.display('No cards on deck, skipping')
            break
        end

        local idx = 1
        local deck_size = #deck

        hand[#hand + 1] = process_card(deck[idx])

        -- O(1) removal: swap with last element instead of shifting
        deck[idx] = deck[deck_size]
        deck[deck_size] = nil
    end
end