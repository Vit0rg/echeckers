--- Validation for standby phase operations

StandbyValidation = {}

function StandbyValidation.valid_biome_index(index)
    return type(index) == 'number' and index >= 1 and index <= 6
end

function StandbyValidation.valid_player(player)
    return type(player) == 'number' and (player == 1 or player == 2)
end

function StandbyValidation.validate_biome_move(player, from, to)
    if not StandbyValidation.valid_player(player) then
        return false, 'Invalid player'
    end
    if not StandbyValidation.valid_biome_index(from) then
        return false, 'Invalid source biome (1-6)'
    end
    if not StandbyValidation.valid_biome_index(to) then
        return false, 'Invalid destination biome (1-6)'
    end
    if from == to then
        return false, 'Source and destination must differ'
    end
    if not Board.biomes or not Board.biomes[player] then
        return false, 'Board not initialized'
    end
    return true
end

function StandbyValidation.validate_set_animal(player, index, hand, hand_index)
    if not StandbyValidation.valid_player(player) then
        return false, 'Invalid player'
    end
    if not StandbyValidation.valid_biome_index(index) then
        return false, 'Invalid biome index (1-6)'
    end
    if not hand or not hand[hand_index] then
        return false, 'Invalid card in hand'
    end
    if not Board.biomes or not Board.biomes[player] then
        return false, 'Board not initialized'
    end
    if not BiomesOps.is_empty(player, index) then
        return false, 'Biome already occupied'
    end
    return true
end

function StandbyValidation.validate_remove_animal(player, index)
    if not StandbyValidation.valid_player(player) then
        return false, 'Invalid player'
    end
    if not StandbyValidation.valid_biome_index(index) then
        return false, 'Invalid biome index (1-6)'
    end
    if not Board.biomes or not Board.biomes[player] then
        return false, 'Board not initialized'
    end
    if BiomesOps.is_empty(player, index) then
        return false, 'No animal on biome'
    end
    return true
end
