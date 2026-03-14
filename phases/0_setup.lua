--[[
This file should be called when duel starts
Biomes, decks and items should be saved as globals
The rest should be unloaded
]]

local function _setup_biomes()
    Biomes_p1 = get_random_biomes()
    Biomes_p2 = get_random_biomes()
    --[[
    print('BIOMES 1:\n')
    table.print(Biomes_p1, 'v')
    print('BIOMES 2:\n')
    table.print(Biomes_p2, 'v')
    ]]
end

local function _setup_decks()   
    local deck_p1 = generate_random_deck()
    local deck_p2 = generate_random_deck()
    --[[
    print('DECK 1:\n')
    table.print(deck_p1, 'v')
    print('DECK 2\n')
    table.print(deck_p2, 'v')
    ]]
end

local function _setup_items()
    return
end

-- Board should be global

local function _setup_board(mode)
    if mode == 'basic' then
        local board = {}

        board[1] = {Biomes_p2[1].emoji, Biomes_p2[2].emoji, Biomes_p2[3].emoji, '🂠', '⛼'}
        board[2] = {'', '', '', LIFE, 'Player 2'}
        board[3] = {'', 'SETUP', '','' , ''}
        board[4] = {'', '', '', LIFE, 'Player 1'}
        board[5] = {Biomes_p1[1].emoji, Biomes_p1[2].emoji, Biomes_p1[3].emoji, '🂠', '⛼'}

        print(update_board(board))
    end
end

local function _setup_hand()
    return
end

-- @1: mode(string) 
local function setup(...)
    local args = {...}
    local mode = args[1] or 'basic'

    if mode == 'basic' then
        _setup_biomes()
        _setup_decks()
        _setup_board(mode)
    end

    if mode == 'elemental' then
        _setup_biomes()
        _setup_items()
        _setup_decks()
        _setup_board()
        return
    end

    if mode == 'advanced' then
        return
    end

end