local random = math.random

local function generate_random_deck()
    local deck = {}

    local index
    for i=1, DECK_SIZE do
        index = random(1, #animals)
        deck[i] = animals[index]
    end

    return deck
end

