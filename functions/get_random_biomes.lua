math.randomseed(1)
local random = math.random

local function get_random_biomes()
    local _selected_biomes = {}
    local max_biomes = 3

    local index
    for i=1, max_biomes do
        index = random(1, #biomes)
        _selected_biomes[i] = biomes[index]
    end

    return _selected_biomes
end