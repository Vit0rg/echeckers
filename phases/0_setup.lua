local function _setup_biomes()
    Biomes_p1 = get_random_biomes()
    Biomes_p2 = get_random_biomes()
end

local function _setup_decks()
    local deck_p1 = generate_random_deck()
    local deck_p2 = generate_random_deck()
    -- table.print(deck_p1, 'v')
    -- table.print(deck_p2, 'v')
end


local function _setup_board(...)
    local args = {...}
    local mode = args[1] or 'easy'

    if mode == 'easy' then
        --[[
        table_field = [b1_p2], [b2_p2], [b3_p2],
                      [],      [phaase],[],
                      [b1_p1], [b2_p1], [b3_p1]
                
        table_extra = [a_p2], [i_p2], [grav_2], 
                      [p2_n], [lp_p2],[nrg_p2],
                      [p1_n], [lp_p1],[nrg_p1],
                      [a_p1], [i_p1], [grav_21
        ]]
    end
end

_setup_biomes()
_setup_decks()