---@diagnostic disable: duplicate-set-field
function _TUI_update_hand(hand, is_hidden)
    local separator = '  '

    if is_hidden == "hidden" then
        local output = ''
        for i = 1, #hand do
            if i > 1 then output = output .. separator end
            output = output .. '🂠'
        end
        print(output)
        return
    end

    -- Print hand (padding already in emoji data)
    local output = ''
    for i = 1, #hand do
        if i > 1 then output = output .. separator end
        output = output .. hand[i]
    end
    print(output)
end

UI.update_hand = function(hand, is_hidden)
    if BUILD == 'TUI' then
        _TUI_update_hand(hand, is_hidden)
    end
end