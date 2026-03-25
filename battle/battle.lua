local _start_battle = function ()
    UI.display('Setting up:')
    setup()

    for i=1, MAX_TURNS do
        UI.display({'Turn: ', i})
        UI.display({'Player turn: ', Player_turn})
        UI.display('Phase: DRAW!')
        draw()
        UI.display('Phase: Standby!')
        standby()
        print()
    end
end

_start_battle()