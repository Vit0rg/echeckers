--[[
This file should be called when duel starts
Biomes, decks and items should be saved as globals
The rest should be unloaded
]]

local function _setup_biomes()
    Biomes = {}
    Biomes[1] = get_random_biomes()
    Biomes[2] = get_random_biomes()
    --[[
    print('BIOMES 1:\n')
    table.print(Biomes_p1, 'v')
    print('BIOMES 2:\n')
    table.print(Biomes_p2, 'v')
    ]]
end

local function _setup_decks()
    Decks={true,true}
    Decks[1] = generate_random_deck()
    Decks[2] = generate_random_deck()
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


local function _setup_starter()
    if math.random(1, 2) == 1 then
        UI.display('Player 1 goes 1st')
        Player_turn=1
        return
    end

    UI.display('Player 2 goes 1st')
    Player_turn=2
end


-- Board should be global
local function _setup_board(MODE)
    if MODE == 'basic' then
        Board = {}

        Board[1] = {Biomes[2][1], Biomes[2][2], Biomes[2][3], 'Deck', 'Trash'}
        Board[2] = {'', '', '', LIFE, BIOMATTER}
        Board[3] = {'', 'SETUP', '','' , ''}
        Board[4] = {'', '', '', LIFE, BIOMATTER}
        Board[5] = {Biomes[1][1], Biomes[1][2], Biomes[1][3], 'Deck', 'Trash'}
    end
end

local function _setup_hands()
    if MODE == 'basic' then
        Hands = {}
        Hands[1] = {}
        Hands[2] = {}

        for i = 1, 2 do
            for j = 1, HAND_SIZE do
                _draw_card(i)
            end
        end
    end
end

local function _setup_ui()
    -- Each player should not see the other hand
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local _setup_trash = function ()
    Trashs = {true, true}
    Trashs[1] = {}
    Trashs[2] = {}
end
-- @1: MODE(string)
local function setup()
    if MODE == 'basic' then
        _setup_biomes()
        _setup_decks()
        _setup_starter()
        _setup_board(MODE)
        _setup_hands()
        _setup_ui()
    end

    if MODE == 'elemental' then
        return
    end

    if MODE == 'advanced' then
        return
    end

end