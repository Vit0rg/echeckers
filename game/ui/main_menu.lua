local _TUI_update_menu = function (output)
    print(output)
end

UI.update_menu = function (output)
    if BUILD == 'TUI' then
        _TUI_update_menu(output)
    end
end
