-- p1 join,
-- p2 join

-- select deck, biomes, items
-- Only occurs once per battle

function start_battle()
    UI.display('Setting up:')
    setup()

    for i=1, MAX_TURNS do
        UI.display({'Turn: ', i})
        UI.display({'Player turn: ', Player_turn})
        UI.display('Phase: DRAW!')
        draw()
        print()
    end
end

start_battle()