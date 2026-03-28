--- Biome operations module
-- Works with flat board structure

BiomesOps = {}

--- Check if biome has no animal
---@param player number (1 or 2)
---@param slot number (1-6)
---@return boolean
function BiomesOps.is_empty(player, slot)
    local biome = BoardModule.get_biome(player, slot)
    return not biome or biome.animal == nil
end

--- Place animal on biome
---@param player number (1 or 2)
---@param slot number (1-6)
---@param card table
function BiomesOps.set_animal(player, slot, card)
    BoardModule.set_biome_animal(player, slot, card)
end

--- Remove animal from biome
---@param player number (1 or 2)
---@param slot number (1-6)
---@return table|nil Removed card
function BiomesOps.remove_animal(player, slot)
    local biome = BoardModule.get_biome(player, slot)
    if not biome or not biome.animal then return nil end

    local removed = biome.animal
    biome.animal = nil
    return removed
end

--- Swap two biomes
---@param player number (1 or 2)
---@param from number (1-6)
---@param to number (1-6)
function BiomesOps.move(player, from, to)
    if from == to then return end
    BoardModule.swap_biomes(player, from, to)
end

--- Get animal on biome
---@param player number (1 or 2)
---@param slot number (1-6)
---@return table|nil
function BiomesOps.get_animal(player, slot)
    local biome = BoardModule.get_biome(player, slot)
    return biome and biome.animal
end

--- Get biome definition
---@param player number (1 or 2)
---@param slot number (1-6)
---@return table|nil
function BiomesOps.get_def(player, slot)
    local biome = BoardModule.get_biome(player, slot)
    return biome and biome.def
end
