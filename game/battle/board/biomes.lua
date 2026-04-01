--- Fields/Biome operations module
-- Works with flat board structure
-- Uses globals: Player_turn, Board, boardModule
-- NOTE: This file is concatenated in build - module available to subsequent files

local fieldsOps = {}

--- Check if biome has no animal
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return boolean
function fieldsOps.is_empty(slot)
    local biome = boardModule.get_biome(slot)
    return not biome or biome.animal == nil
end

--- Place animal on biome
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @param card table
function fieldsOps.set_animal(slot, card)
    boardModule.set_biome_animal(slot, card)
end

--- Remove animal from biome
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return table|nil Removed card
function fieldsOps.remove_animal(slot)
    local biome = boardModule.get_biome(slot)
    if not biome or not biome.animal then return nil end

    local removed = biome.animal
    biome.animal = nil
    return removed
end

--- Swap two biomes
-- Uses globals: Player_turn, Board, boardModule
-- @param from number (1-6)
-- @param to number (1-6)
function fieldsOps.move(from, to)
    if from == to then return end
    boardModule.swap_biomes(from, to)
end

--- Get animal on biome
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return table|nil
function fieldsOps.get_animal(slot)
    local biome = boardModule.get_biome(slot)
    return biome and biome.animal
end

--- Get biome definition
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return table|nil
function fieldsOps.get_def(slot)
    local biome = boardModule.get_biome(slot)
    return biome and biome.def
end

-- Module is local, available to files after this in build order
-- No export needed - files are concatenated in build_battle.txt
