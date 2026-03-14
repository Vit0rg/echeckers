math.randomseed(1)
local random = math.random

local function generate_random_deck()
    local deck = {}
    local deck_size = 10

    local index
    for i=1, deck_size do
        index = random(1, #animals)
        deck[i] = animals[index]
    end

    return deck
end

