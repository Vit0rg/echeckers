--- Biome operations module
-- Direct operations on biome animal slots

BiomesOps = {}

--- Check if biome has no animal
---@param player number (1 or 2)
---@param index number (1-6)
---@return boolean
function BiomesOps.is_empty(player, index)
    local biome = BoardModule.get_biome(player, index)
    return not biome or biome.animal == nil
end

--- Place animal on biome
---@param player number (1 or 2)
---@param index number (1-6)
---@param card table
function BiomesOps.set_animal(player, index, card)
    local biome = BoardModule.get_biome(player, index)
    if biome then
        biome.animal = card
        BoardModule.sync()
    end
end

--- Remove animal from biome
---@param player number (1 or 2)
---@param index number (1-6)
---@return table|nil Removed card
function BiomesOps.remove_animal(player, index)
    local biome = BoardModule.get_biome(player, index)
    if not biome or not biome.animal then return nil end

    local removed = biome.animal
    biome.animal = nil
    BoardModule.sync()
    return removed
end

--- Swap two biomes
---@param player number (1 or 2)
---@param from number (1-6)
---@param to number (1-6)
function BiomesOps.move(player, from, to)
    if from == to or not Board.biomes[player] then return end
    Board.biomes[player][from], Board.biomes[player][to] =
    Board.biomes[player][to], Board.biomes[player][from]
    BoardModule.sync()
end

--- Get animal on biome
---@param player number (1 or 2)
---@param index number (1-6)
---@return table|nil
function BiomesOps.get_animal(player, index)
    local biome = BoardModule.get_biome(player, index)
    return biome and biome.animal
end

--- Get biome definition
---@param player number (1 or 2)
---@param index number (1-6)
---@return table|nil
function BiomesOps.get_def(player, index)
    local biome = BoardModule.get_biome(player, index)
    return biome and biome.def
end
