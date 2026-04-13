--[[
This file should be called when duel starts
Fields, decks and items should be saved as globals
The rest should be unloaded
]]

local function _setup_fields()
    Fields = {}
    Fields[1] = get_random_fields()
    Fields[2] = get_random_fields()
end

local function _setup_decks()
    Decks = { true, true }
    Decks[1] = generate_random_deck()
    Decks[2] = generate_random_deck()
end

local function _setup_items()
    return
end

local function _setup_starter()
    if math.random(1, 2) == 1 then
        UI.display('Player 1 goes 1st')
        Player_turn = 1
        return
    end

    UI.display('Player 2 goes 1st')
    Player_turn = 2
end

local function _setup_board(MODE)
    if MODE == 'basic' then
        Board = BoardOps.init(Fields[1], Fields[2])
    end
end

local function _setup_hands()
    if MODE == 'basic' then
        Hands = {}
        Hands[1] = {}
        Hands[2] = {}

        for i = 1, 2 do
            _draw_card(Decks[i], Hands[i], HAND_SIZE)
        end
    end
end

local function _setup_ui()
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local _setup_trash = function()
    Trash = { {}, {} }
end

local function setup()
    if MODE == 'basic' then
        _setup_fields()
        _setup_decks()
        _setup_starter()
        _setup_board(MODE)
        _setup_hands()
        _setup_trash()
        _setup_ui()
    end

    if MODE == 'elemental' then
        return 2
    end

    if MODE == 'astrological' then
        return 3
    end

    if MODE == 'advanced' then
        return 4
    end
end
